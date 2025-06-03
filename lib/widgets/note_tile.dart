import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/screens/note_edit_screen.dart';

String formatDate(DateTime date){
  return '${date.day}/${date.month}/${date.hour}:${date.minute.toString().padLeft(2,'0')}';
}

class NoteTile extends StatelessWidget {
  final NoteModel note;
  const NoteTile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(
          note.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
            note.description.length>50
                ?'${note.description.substring(0,50)}'
                : note.description,
          ),
          const SizedBox(height: 4,),
            Text(
              'Created: ${formatDate(note.createdTime)}',
              style: const TextStyle(fontSize: 12,color: Colors.grey),
            )
          ]
        ),
        trailing: IconButton(
            icon: const Icon(Icons.delete,color: Colors.red,),
            onPressed: (){
              note.delete();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Note deleted'))
              );
            },
          ),
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (_)=> NoteEditScreen(note: note)));
        },
      ),
    );
  }
}
