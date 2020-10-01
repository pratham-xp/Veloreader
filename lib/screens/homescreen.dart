import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/booklist_edit.dart';
import '../widgets/load_asset.dart';
import '../widgets/appdrawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Veloreader',
          style: GoogleFonts.pacifico(),
        ),
      ),
      drawer: AppDrawer(),
      body: LoadAsset(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(BookListEdit.routeName),
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
