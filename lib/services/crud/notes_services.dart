import "package:flutter/foundation.dart";
import "package:sqflite/sqflite.dart";
import "package:path/path.dart" show join;
import "package:path_provider/path_provider.dart" ;

class DatabaseAlreadyOpenException implements Exception {}
class UnableToGetDocumentsDirectory implements Exception {}
class DatabaseIsNotOpen implements Exception {}
class CouldNotDeleteUser implements Exception {}
class UserAlreadyExists implements Exception {}

class NotesService {

  Database? _db;

  Future<DatabaseUser> createUser({required String email}) async {
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where : "email = ?",
      whereArgs: [email.toLowerCase()],
    );

    if(results.isNotEmpty){
      throw UserAlreadyExists();
    }

    final userId = await db.insert(userTable,{
      emailcolumn : email.toLowerCase(),
    });

    return DatabaseUser(
      id: userId,
      email: email,
    );
  }

  Future<void> deleteUser({required String email}) async {
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      userTable,
      where: "email = ?",
      whereArgs: [email.toLowerCase()],
    );

    if(deletedCount != 1){
      throw CouldNotDeleteUser();
    }

  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if(db == null){
      throw DatabaseIsNotOpen();
    }
    else{
      return db;
    }
  }

  Future<void> close() async {
    final db = _db;
    if(db == null){
      throw DatabaseIsNotOpen();
    }
    else{
      await db.close();
      _db = null;
    }
  }

  Future<void> open() async {
    if(_db != null){
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, "notes.db");
      final db = await openDatabase(dbPath);
      _db = db;

      // creates the required tables
      await db.execute(createUserTable); 
      await db.execute(createNoteTable);

    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}

@immutable
class DatabaseUser {
  final int id;
  final String email;

  const DatabaseUser({
    required this.id,
    required this.email,
  });
  
  DatabaseUser.fromRow(Map<String, Object?> map)
      : id = map[idcolumn] as int,
        email = map[emailcolumn] as String;

  @override
  String toString() => "Person, ID = $id, email = $email";

  @override 
  bool operator ==(covariant DatabaseUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

}

class DatabaseNode {
  final int id;
  final int userId;
  final String text;
  final bool isSyncedWithCloud;

  const DatabaseNode({
    required this.id,
    required this.userId,
    required this.text,
    required this.isSyncedWithCloud,
  });

  DatabaseNode.fromRow(Map<String, Object?> map)
      : id = map[idcolumn] as int,
        userId = map[userIdColumn] as int,
        text = map[textColumn] as String,
        isSyncedWithCloud = (map[isSyncedWithCloudColumn] as int) == 1 ? true : false;

  @override
  String toString() => "Note, ID = $id, User ID = $userId, Text = $text, Is Synced = $isSyncedWithCloud";

  @override
  bool operator ==(covariant DatabaseNode other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

}

const noteTable = "notes";
const userTable = "user";
const dbName = "notes.db";
const idcolumn = "id";
const emailcolumn = "email";
const userIdColumn = "user_id";
const textColumn = "text";
const isSyncedWithCloudColumn = "is_synced_with_cloud";
const createUserTable = '''CREATE TABLE IF NOT EXISTS "user" (
                                "id"	INTEGER NOT NULL,
                                "email"	TEXT NOT NULL UNIQUE,
                                PRIMARY KEY("id" AUTOINCREMENT)
                              ); ''';
const createNoteTable = '''CREATE TABLE "note" (
                                "id"	INTEGER NOT NULL,
                                "user_id"	INTEGER NOT NULL,
                                "text"	TEXT,
                                "is_synced_with_server"	INTEGER DEFAULT 0,
                                PRIMARY KEY("id" AUTOINCREMENT),
                                FOREIGN KEY("user_id") REFERENCES "user"("id")
                              ); ''';
