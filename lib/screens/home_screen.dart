import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/theme/app_theme.dart';
import 'package:note_app/utils/hive_boxes.dart';
import 'package:provider/provider.dart';
import '../widgets/note_tile.dart';
import 'note_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 enum SortOption{ title, date }
class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery= '';
  SortOption _selectedSort= SortOption.date;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
            onPressed: (){
              final themeProvider= Provider.of<ThemeProvider>(context,listen: false);
              themeProvider.toggleTheme(!themeProvider.isDarkMode);
            }, icon: Icon(
          Provider.of<ThemeProvider>(context).isDarkMode
              ?Icons.dark_mode
              :Icons.light_mode,
        )),
        title: const Text('My Notes'),
        centerTitle: true,
        actions: [
          PopupMenuButton<SortOption>(
            icon: const Icon(Icons.sort),
              onSelected: (value){
              setState(() {
                _selectedSort= value;
              });
              },
              itemBuilder: (context)=> [
                const PopupMenuItem(
                  value: SortOption.date,
                    child: Text('Sort by Date'),),
                const PopupMenuItem(
                  value: SortOption.title,
                    child: Text('Sort by Title'))
              ])
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search notes...',
                filled: true,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor??
                    Theme.of(context).cardColor,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value){
                setState(() {
                  _searchQuery= value.toLowerCase();
                });
              },
            ),
            )),
      ),
      body: ValueListenableBuilder<Box<NoteModel>>(
          valueListenable: Boxes.getNotes().listenable(),
          builder: (context,box,_){
            final allNotes= box.values.toList().cast<NoteModel>();
            final notes= allNotes.where((note){
              return note.title.toLowerCase().contains(_searchQuery);
            }).toList();

            if (_selectedSort== SortOption.title){
              notes.sort((a,b)=> a.title.toLowerCase().compareTo(b.title.toLowerCase()));
            }else{
              notes.sort((a,b)=> b.createdTime.compareTo(a.createdTime));
            }
            
            if (notes.isEmpty){
              return const Center(
                child: Text('No matching notes'),
              );
            }
            return ListView.builder(
              itemCount: notes.length,
                itemBuilder: (context, index){
                  return NoteTile(note: notes[index]);
                });
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (_)=> const NoteEditScreen()));
          },
          child: const Icon(Icons.add),
          ),
      
    );
  }
}
