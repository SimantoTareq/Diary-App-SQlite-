import 'package:diary_app_sqlite/screens/add-note/add_note_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../modles/note.dart';

class ItemNote extends StatelessWidget {
  final Note note;
  const ItemNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_)=> AddNoteScreen(note: note,)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),

        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red
              ),
              child:Column(
                children: [
                  Text(DateFormat(DateFormat.ABBR_MONTH).format(note.createdAt), style: const TextStyle(color: Colors.white70),),
                  SizedBox(height: 3,),
                  Text(DateFormat(DateFormat.DAY).format(note.createdAt), style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 3,),
                  Text(note.createdAt.year.toString(), style: TextStyle(color: Colors.white70),)
                ],
              ) ,
            ),
            const SizedBox(width: 15,),
            Expanded(child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(note.title,
                      style: Theme.of(context).textTheme.titleMedium,
                       maxLines: 1,
                      overflow: TextOverflow.ellipsis,),
                    ),
                    Text(DateFormat(DateFormat.HOUR_MINUTE).format(note.createdAt),style: Theme.of(context).textTheme.titleMedium,)
                  ],
                ),
                Text(note.description,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  height: 1.5,

                ),
                maxLines: 3,
                  overflow: TextOverflow.ellipsis,)
              ],
            ))
          ],
        ),

      ),
    );
  }
}
