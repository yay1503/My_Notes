import "package:flutter/foundation.dart";
import "package:sqflite/sqflite.dart";
import "package:path/path.dart" show join;
import "package:path_provider/path_provider.dart" show getApplicationDocumentsDirectory;

class

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
const dbName = "notes.db";
const idcolumn = "id";
const emailcolumn = "email";
const userIdColumn = "user_id";
const textColumn = "text";
const isSyncedWithCloudColumn = "is_synced_with_cloud";