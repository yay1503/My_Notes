import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_notes/services/cloud/cloud_note.dart';
import 'package:my_notes/services/cloud/cloud_storage_constants.dart';
import 'package:my_notes/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {

  final notes = FirebaseFirestore.instance.collection('notes');

  Future<Iterable<CloudNote>> getNotes({required String documentId}) async {
    try {
      return await notes.where(
        ownerUserIdFieldName,
        isEqualTo: documentId,
      )
      .get()
      .then(
        (value) => value.docs.map((doc) {
        return CloudNote(
          documentId: doc.id,
          ownerUserId: doc.data()[ownerUserIdFieldName] as String,
          text: doc.data()[textFieldName] as String
        );
      }));
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  void createNewNote({required String owneruserId}) async  {
    notes.add({
      ownerUserIdFieldName : owneruserId,
      textFieldName : '',
    });
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}// to make it a singelton class

