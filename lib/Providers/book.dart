import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Book with ChangeNotifier {
  final String id;
  final String title;
  final String category;
  final String authors;
  final String coverPath;
  final String path;

  Book({
    this.id,
    this.title,
    this.category,
    this.authors,
    this.coverPath,
    this.path,
  });

  List<String> _categories = [
    'Choose',
    'All',
    'Action & Adventure',
    'Arts, Film & Photography',
    'Biographies, Diaries & True Accounts',
    'Children\'s & Young Adult',
    'Craft, Hobbies & Home',
    'Crime, Thriller & Mystery',
    'Health, Family & Personal Development',
    'History',
    'Literature & Fiction',
    'Religion & Spirituality',
    'Romance',
    'Science Fiction & Fantasy',
    'Textbooks & Study Guides'
  ];

  List<String> get categoryList {
    return [..._categories];
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
