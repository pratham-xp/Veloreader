import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import './screens/booklist_edit.dart';
import './screens/words_screen.dart';
import './screens/excerpts_screen.dart';
import './screens/homescreen.dart';
import './screens/notes_screen.dart';
import './Providers/books.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Books(),
        ),
      ],
      child: MaterialApp(
          title: 'Veloreader',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            accentColor: Colors.amber,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.abelTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: HomeScreen(),
          routes: {
            ExcerptsScreen.routeName: (ctx) => ExcerptsScreen(),
            NotesScreen.routeName: (ctx) => NotesScreen(),
            WordsScreen.routeName: (ctx) => WordsScreen(),
            BookListEdit.routeName: (ctx) => BookListEdit(),
          }),
    );
  }
}
