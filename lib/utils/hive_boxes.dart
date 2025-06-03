
import 'package:hive/hive.dart';
import 'package:note_app/models/note_model.dart';

class Boxes{
  static Box<NoteModel>getNotes()=> Hive.box<NoteModel>('notes');
}