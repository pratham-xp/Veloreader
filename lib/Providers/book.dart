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
    @required this.id,
    @required this.title,
    @required this.category,
    @required this.authors,
    this.coverPath,
    this.path,
  });

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
