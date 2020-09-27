import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:veloreader/Providers/books.dart';

import 'package:epub_viewer/epub_viewer.dart';
//import 'package:epub_view/epub_view.dart';
import '../constants.dart';
import 'book_item.dart';
import 'category_list.dart';
import 'search_bar.dart';

class LoadAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Books>(context, listen: false).getBooks(),
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
                  SearchBox(onChanged: (value) {}),
                  CategoryList(),
                  SizedBox(height: kDefaultPadding / 2),
                  Expanded(
                    child: Stack(children: <Widget>[
                      // Our background
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
                        itemCount: bookData.items.length,
                        itemBuilder: (ctx, i) => GestureDetector(
                            child: BookItem(
                              itemIndex: i,
                              book: bookData.items[i],
                            ),
                            onTap: () {
                              EpubViewer.setConfig(
                                themeColor: Theme.of(context).primaryColor,
                                identifier: "iosBook",
                                scrollDirection: EpubScrollDirection.VERTICAL,
                                allowSharing: true,
                                enableTts: true,
                              );

                              EpubViewer.open(
                                bookData.items[i].path,
                                lastLocation:
                                    null, // first page will open up if the value is null
                              );
                            }),
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