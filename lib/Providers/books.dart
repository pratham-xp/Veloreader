import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import './book.dart';

class Books with ChangeNotifier {
  List<Book> _items = [];

  List<Book> get items {
    return [..._items];
  }

  Book findById(String id) {
    return _items.firstWhere((ele) => ele.id == id);
  }

  Future<void> fetchAndSetBooks() async {
    const url = 'https://veloreader-31b18.firebaseio.com/books.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(json.decode(response.body));
      if (extractedData == null) {
        return;
      }
      final List<Book> loadedBooks = [];
      extractedData.forEach((bookId, bookData) {
        loadedBooks.add(Book(
          id: bookId,
          title: bookData['title'],
          category: bookData['category'],
          authors: bookData['authors'],
          path: bookData['path'],
          coverPath: bookData['coverPath'],
        ));
      });
      _items = loadedBooks;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> addBook(Book book) async {
    const url = 'https://veloreader-31b18.firebaseio.com/books.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': book.title,
          'category': book.category,
          'authors': book.authors,
          'path': book.path,
          'coverPath': book.coverPath,
        }),
      );
      final newBook = Book(
        title: book.title,
        category: book.category,
        authors: book.authors,
        path: book.path,
        coverPath: book.coverPath,
        id: json.decode(response.body)['name'],
      );
      _items.add(newBook);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateBook(String id, Book newBook) async {
    final bookIndex = _items.indexWhere((book) => book.id == id);
    if (bookIndex >= 0) {
      final url = 'https://veloreader-31b18.firebaseio.com/books.json$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newBook.title,
            'category': newBook.category,
            'authors': newBook.authors,
            'path': newBook.path,
            'coverPath': newBook.coverPath,
          }));
      _items[bookIndex] = newBook;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
