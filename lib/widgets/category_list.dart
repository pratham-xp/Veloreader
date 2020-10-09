import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Providers/book.dart';
import '../constants.dart';

class CategoryList extends StatefulWidget {
  int get index {
    return selectedIndex;
  }

  @override
  _CategoryListState createState() => _CategoryListState();
}

int selectedIndex = 0;

class _CategoryListState extends State<CategoryList> {
  List categories = Book().categoryList.sublist(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            height: 20,
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: kDefaultPadding,
              right: index == categories.length - 1 ? kDefaultPadding : 0,
            ),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: index == selectedIndex
                  ? Colors.blue.withOpacity(0.4)
                  : Colors.pink[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              categories[index],
              style: GoogleFonts.raleway(
                  color: index == selectedIndex
                      ? Colors.blue[900]
                      : Colors.pink[900]),
            ),
          ),
        ),
      ),
    );
  }
}
