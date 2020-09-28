import 'package:epub_kitty/epub_kitty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/books.dart';
import '../constants.dart';
import 'book_item.dart';
import 'category_list.dart';
import 'search_bar.dart';

class LoadAsset extends StatefulWidget {
  @override
  _LoadAssetState createState() => _LoadAssetState();
}

class _LoadAssetState extends State<LoadAsset> {
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
                              EpubKitty.setConfig(
                                  "book", "#32a852", "vertical", true);
                              EpubKitty.open(
                                bookData.items[i].path,
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
