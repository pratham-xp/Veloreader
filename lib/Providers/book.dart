import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Book with ChangeNotifier {
  final String id;
  final String title;
  final String path;
  final List<String> authors;
  final Image coverImage;

  Book({
    @required this.id,
    @required this.title,
    @required this.authors,
    this.coverImage,
    this.path,
  });

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
