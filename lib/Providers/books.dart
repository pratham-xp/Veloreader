import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:epub/epub.dart';

import './book.dart';

class Books with ChangeNotifier {
  List<Book> _items = [];
  List<Book> get items {
    return [..._items];
  }

  Future<List<Book>> getBooks() async {
    List<Book> bookList = await load();
    return [...bookList];
  }

  Book findById(String id) {
    return _items.firstWhere((ele) => ele.id == id);
  }

  Future<List<Book>> load() async {
    WidgetsFlutterBinding.ensureInitialized();

    var targetFile = await rootBundle.load('assets/eBooks/Subtle Art.epub');
    Uint8List audioUint8List = targetFile.buffer
        .asUint8List(targetFile.offsetInBytes, targetFile.lengthInBytes);
    List<int> bytes = audioUint8List.cast<int>();

    EpubBook epubBook = await EpubReader.readBook(bytes);

    String title = epubBook.Title;
    //String author = epubBook.Author;
    List<String> authors = epubBook.AuthorList;
    //img.Image pic = epubBook.CoverImage;
    print(authors);
/* 
    io.Directory tempDir = await getTemporaryDirectory();

    img.Image thumbnail = img.copyResize(pic, width: 120, height: 180);
    io.File('${tempDir.path}/Subtle Art.jpg')
        .writeAsBytesSync(img.encodeJpg(thumbnail));
    var image = IMG.FileImage(io.File('${tempDir.path}/Subtle Art.jpg)'));
    IMG.Image cover = IMG.Image(image: image); */
    print('loaded');
    _items.add(Book(
      id: DateTime.now().toString(),
      title: title,
      authors: authors,
      path: 'assets/eBooks/Subtle Art.epub',
    ));
    print(_items.length);
    notifyListeners();
    return _items;
  }
}
