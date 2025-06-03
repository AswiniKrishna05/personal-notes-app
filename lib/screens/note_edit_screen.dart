import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';

import '../utils/hive_boxes.dart';

class NoteEditScreen extends StatefulWidget {
  final NoteModel? note;

  const NoteEditScreen({super.key,this.note});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _formKey= GlobalKey<FormState>();
  late TextEditingController _titleContoller;
  late TextEditingController _descController;

  @override
  void initState(){
    super.initState();
    _titleContoller= TextEditingController(text: widget.note?.title??'');
    _descController= TextEditingController(text: widget.note?.description??'');
  }

  @override
  void dispose(){
    _titleContoller.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveNote(){
    if (_formKey.currentState!.validate()){
      final title= _titleContoller.text;
      final description= _descController.text;

      if (widget.note!= null){
        widget.note!
            ..title=title
        ..description=description
        ..createdTime= DateTime.now()
        ..save();
      }else{
        final newNote= NoteModel(
          title: title,
          description: description,
          createdTime: DateTime.now()
        );
        final box= Boxes.getNotes();
        box.add(newNote);
      }
      Navigator.pop(context);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note!= null? 'Edit Note': 'New Note'),
        actions: [
          IconButton(
              onPressed: _saveNote,
              icon: const Icon(Icons.save),),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleContoller,
                decoration: const InputDecoration(
                  labelText: 'Title'
                ),
                validator: (value)=> value!.isEmpty? 'Enter a title': null,
              ),
              const SizedBox(height: 12,),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Description'
                ),
                maxLines: 5,
                validator: (value)=> value!.isEmpty? 'Enter description': null,
              )
            ],
          )),
      ),
    );
  }
}

