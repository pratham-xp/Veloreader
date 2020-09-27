import 'package:flutter/material.dart';

import '../screens/words_screen.dart';
import '../screens/notes_screen.dart';
import '../screens/excerpts_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: Text('Hello worm'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.book),
          title: Text('Bookshelf'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.format_quote),
          title: Text('Excerpts'),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(ExcerptsScreen.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.note_add),
          title: Text('Notes'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(NotesScreen.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.sort_by_alpha),
          title: Text('Saved Words'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(WordsScreen.routeName);
          },
        ),
      ],
    ));
  }
}
