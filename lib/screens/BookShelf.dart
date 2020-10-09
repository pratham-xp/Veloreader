import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veloreader/Providers/book.dart';
import 'package:veloreader/widgets/category_list.dart';

import 'booklist_edit.dart';
import '../Providers/books.dart';
import '../constants.dart';
import '../widgets/book_item.dart';
import '../widgets/category_list.dart';

int index = 0;

class BookShelf extends StatefulWidget {
  @override
  _BookShelfState createState() => _BookShelfState();
}

class _BookShelfState extends State<BookShelf> {
  @override
  void _initState() {
    void _setState() {
      index = CategoryList().index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Books>(context, listen: false).fetchAndSetBooks(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Consumer<Books>(
            builder: (ctx, bookData, child) => SafeArea(
              bottom: false,
              child: Column(
                children: <Widget>[
                  //SearchBox(onChanged: (value) {}),
                  // SearchBar(
                  //     onSearch: null,
                  //     onItemFound: null,
                  //     searchBarStyle: SearchBarStyle(
                  //       backgroundColor: Colors.amber[100],
                  //       padding: EdgeInsets.all(10),
                  //       borderRadius: BorderRadius.circular(10),
                  //     )),
                  SizedBox(height: 15),
                  CategoryList(),
                  SizedBox(height: kDefaultPadding / 2),
                  Expanded(
                    child: Stack(children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 70),
                        decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: bookData.items
                            .where((element) =>
                                element.category == Book().categoryList[index])
                            .length,
                        itemBuilder: (ctx, i) => GestureDetector(
                          child: BookItem(
                            itemIndex: i,
                            book: bookData.items[i],
                          ),
                          onTap: () {
                            EpubViewer.setConfig(
                              themeColor: Theme.of(context).accentColor,
                              identifier: "iosBook",
                              scrollDirection: EpubScrollDirection.HORIZONTAL,
                              allowSharing: true,
                              enableTts: true,
                            );
                            EpubViewer.openAsset(
                              bookData.items[i].path,
                              lastLocation: null,
                            );
                          },
                          onLongPress: () => Navigator.of(context).pushNamed(
                              BookListEdit.routeName,
                              arguments: bookData.items[i].id),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
