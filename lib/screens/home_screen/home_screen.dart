import 'package:diary_app_sqlite/providers/notes/notes_provider.dart';
import 'package:diary_app_sqlite/respository/notes_respository.dart';
import 'package:diary_app_sqlite/screens/add-note/add_note_screen.dart';
import 'package:diary_app_sqlite/screens/home_screen/widgets/item_note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Diary"),

        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            setState(() {

            });

          }, icon: Icon(Icons.refresh) )
        ],

      ),
      body:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<NotesProvider>(
              builder: ( context, provider, child){
                return provider.notes.isEmpty? Center(child: Text("Empty"),): ListView(
                  children: provider.notes.map((e) => ItemNote(note: e)).toList()
                );
              }
            ),
          ),


 //          FutureBuilder(
 //            future: NotesRespository.getNotes(),
 //            builder: (context, snapshot){
 //              if(snapshot.connectionState == ConnectionState.done){
 //                if(snapshot.data == null || snapshot.data!.isEmpty){
 //                  return const Center(child: Text("Empty"),);
 //                }
 //                return ListView(
 //                  padding: EdgeInsets.all(15),
 //                  children: [
 //                    for(var note in snapshot.data!)
 //                      ItemNote(note: note,)
 //                  ],
 //                );
 //              }
 // return const SizedBox();
 //            }
 //
 //
 //          ),

      // ListView(
      //   padding: EdgeInsets.all(15),
      //   children: [
      //     ItemNote(),
      //     ItemNote(),
      //     ItemNote(),
      //     ItemNote(),
      //     ItemNote(),
      //
      //
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:(_)=> AddNoteScreen() ));

        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),

      ),
    );
  }
}
