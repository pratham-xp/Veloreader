import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import './screens/words_screen.dart';
import './screens/excerpts_screen.dart';
import './screens/homescreen.dart';
import './screens/notes_screen.dart';
import './Providers/books.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Books(),
        ),
        //ChangeNotifierProvider(
        //create: (ctx) => Book(),
        //),
        //ChangeNotifierProvider(
        //create: (ctx) => Orders(),
        //)
      ],
      child: MaterialApp(
          title: 'Veloreader',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            accentColor: kPrimaryColor,
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
          }),
    );
  }
}
