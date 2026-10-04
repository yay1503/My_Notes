import 'package:flutter/material.dart';
import 'package:my_notes/services/crud/notes_services.dart';

typedef DeleteNoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {

  final List<DatabaseNote> notes;
  final DeleteNoteCallback onDeleteNote;

  const NotesListView({super.key, required this.notes, required this.onDeleteNote});



  @override
  Widget build(BuildContext context) {
     return ListView.builder(
                          itemCount : notes.length,
                          itemBuilder : (context, index) {
                            final note = notes[index];
                            return ListTile(
                              title : Text(
                                note.text,
                                maxLines : 1,
                                softWrap : true,
                                overflow : TextOverflow.ellipsis,
                                ),
                                trailing : IconButton(
                                  onPressed : (){
                                    final shouldDelete = await showDeleteDialog(context);
                                  },
                                  icon : Icon(Icons.delete),
                                )
                            );
                          }
                        );
  }
}