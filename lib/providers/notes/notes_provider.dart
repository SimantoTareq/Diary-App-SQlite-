import 'package:diary_app_sqlite/respository/notes_respository.dart';
import 'package:flutter/cupertino.dart';

import '../../modles/note.dart';

class NotesProvider with ChangeNotifier{
  List<Note> notes =[];

  getNotes() async{
     notes = await NotesRespository.getNotes();
     notifyListeners();
  }

  insert({required Note note}) async{
    await NotesRespository.insert(note: note);
    getNotes();

  }
  update({required Note note}) async{
    await NotesRespository.update(note: note);
    getNotes();
  }
  Future<bool>delete({required Note note}) async{
    await NotesRespository.delete(note: note);
    getNotes();
    return true;
  }
}