import 'package:diary_app_sqlite/modles/note.dart';
import 'package:diary_app_sqlite/providers/notes/notes_provider.dart';
import 'package:diary_app_sqlite/respository/notes_respository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;

  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titile = TextEditingController();
  final _description = TextEditingController();
  @override
  void initState() {
    if(widget.note != null){
      _titile.text = widget.note!.title;
      _description.text= widget.note!.description;
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        actions: [

         widget.note !=null? IconButton(
              onPressed: () {
              showDialog(context: context, builder: (context) =>AlertDialog(
                content: Text("Are you sure, you want to delete this note? "),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("No")),
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                    _deleteNote();
                  }, child: Text("Yes"))
                ],
              ));

          }, icon: Icon(Icons.delete)) : const SizedBox(),
          IconButton(
              onPressed:widget.note == null? _insertNote: _updatetNote,
              icon: Icon(Icons.done)),
        ]




      ),
      body:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: _titile,
              decoration: InputDecoration(

                hintText: "Title",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

              ),


            ),
            SizedBox(height: 15,),
            Expanded(
              child: TextField(
                controller: _description,
                decoration: InputDecoration(
                    hintText: "Start Typing here......",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),

                  maxLines: 50,

              ),
            ),

          ],
        ),
      ),
    );
  }
  _insertNote() async{
    final note = Note(
        title: _titile.text,
        description: _description.text,
        createdAt: DateTime.now()
    );
    Provider.of<NotesProvider>(context,listen: false).insert(note: note);

   //await NotesRespository.insert(note: note);
  }

  _updatetNote() async{
    final note = Note(
      id: widget.note!.id,
        title: _titile.text,
        description: _description.text,
        createdAt: widget.note!.createdAt
    );
    Provider.of<NotesProvider>(context,listen: false).update(note: note);
    //await NotesRespository.update(note: note);
  }

  _deleteNote() async{
    Provider.of<NotesProvider>(context,listen: false).delete(note: widget.note!).then((isdone){

      Navigator.pop(context);
    });


    // NotesRespository.delete(note: widget.note!).then((e){
    //   Navigator.pop(context);
    // });
  }
}
