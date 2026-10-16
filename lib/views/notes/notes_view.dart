import 'package:flutter/material.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/enums/menu_action.dart';
import 'package:my_notes/services/auth/auth_service.dart';
import 'package:my_notes/services/cloud/cloud_note.dart';
import 'package:my_notes/services/cloud/firebase_cloud_storage.dart';
import 'package:my_notes/utilities/dialogs/logout_dialog.dart';
import 'package:my_notes/views/notes/notes_list_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {

  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id ;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : const Text("Your Notes"),
        actions : [
          IconButton(
            onPressed : () {
              Navigator.of(context).pushNamed(createUpdateNoteRoute);
            },
            icon : const Icon(Icons.add)
          ),
          PopupMenuButton<MenuAction>(
            onSelected : (value) async {
              switch(value) {
                
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute, 
                      (_) => false,
                    );
                  }
              }
            },
            itemBuilder : (context) {
              return const [
                PopupMenuItem<MenuAction>(
                value : MenuAction.logout,
                child : Text("Logout"),
                ),
              ];
          },)
        ],
      ),
      body : StreamBuilder(
                stream : _notesService.allNotes(ownerUserId: userId),
                builder : (context , snapshot) {
                  switch(snapshot.connectionState) {
                    case ConnectionState.waiting :
                    case ConnectionState.active :
                      final allNotes = snapshot.data ?? [];
                      return NotesListView(
                        notes : allNotes,
                        onDeleteNote : (note) async {
                          await _notesService.deleteNote(documentId: note.documentId);
                        }, onTap: (CloudNote note) { 
                          Navigator.of(context).pushNamed(
                            createUpdateNoteRoute,
                            arguments : note,
                          );
                         },
                      ); 

                    default :
                     return const CircularProgressIndicator();
                  }

                }
      )
              
    );
  }
}
