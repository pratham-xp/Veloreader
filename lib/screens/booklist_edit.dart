import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Providers/book.dart';
import '../Providers/books.dart';

class BookListEdit extends StatefulWidget {
  static const routeName = '/edit-booklist';
  @override
  _BookListEditState createState() => _BookListEditState();
}

class _BookListEditState extends State<BookListEdit> {
  final _categoryFocusNode = FocusNode();
  final _authorsFocusNode = FocusNode();
  final _bookPathFocusNode = FocusNode();
  final _coverPathFocusNode = FocusNode();
  final _coverPathController = TextEditingController();
  final _submitButtonFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedBook = Book(
      id: null, title: '', authors: '', category: '', path: '', coverPath: '');
  var _initValues = {
    'title': '',
    'authors': '',
    'category': '',
    'path': '',
    'coverPath': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _coverPathFocusNode.addListener(_updateCoverPath);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final bookId = ModalRoute.of(context).settings.arguments as String;
      if (bookId != null) {
        _editedBook =
            Provider.of<Books>(context, listen: false).findById(bookId);
        _initValues = {
          'title': _editedBook.title,
          'authors': _editedBook.authors,
          'category': _editedBook.category,
          'path': _editedBook.path,
          'coverPath': _editedBook.coverPath,
        };
        _coverPathController.text = _editedBook.coverPath;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _coverPathFocusNode.removeListener(_updateCoverPath);
    _categoryFocusNode.dispose();
    _authorsFocusNode.dispose();
    _bookPathFocusNode.dispose();
    _coverPathFocusNode.dispose();
    _coverPathController.dispose();
    _submitButtonFocusNode.dispose();
    super.dispose();
  }

  void _updateCoverPath() {
    if (!_coverPathFocusNode.hasFocus) {
      if ((!_coverPathController.text.endsWith('.png') &&
          !_coverPathController.text.endsWith('.jpg') &&
          !_coverPathController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedBook.id != null) {
      await Provider.of<Books>(context, listen: false)
          .updateBook(_editedBook.id, _editedBook);
    } else {
      try {
        await Provider.of<Books>(context, listen: false).addBook(_editedBook);
      } catch (error) {
        print(error);
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //final model = Provider.of<Books>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Veloreader',
          style: GoogleFonts.pacifico(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_categoryFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a category.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedBook = Book(
                          title: value,
                          authors: _editedBook.authors,
                          category: _editedBook.category,
                          path: _editedBook.path,
                          coverPath: _editedBook.coverPath,
                          id: _editedBook.id,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['category'],
                      decoration: InputDecoration(labelText: 'Category'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      focusNode: _categoryFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_authorsFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a category.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedBook = Book(
                          title: _editedBook.title,
                          category: value,
                          authors: _editedBook.authors,
                          coverPath: _editedBook.coverPath,
                          path: _editedBook.path,
                          id: _editedBook.id,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['authors'],
                      decoration: InputDecoration(labelText: 'Authors'),
                      maxLines: 2,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      focusNode: _authorsFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_bookPathFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter author\'s name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedBook = Book(
                          title: _editedBook.title,
                          category: _editedBook.category,
                          authors: value,
                          coverPath: _editedBook.coverPath,
                          path: _editedBook.path,
                          id: _editedBook.id,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['path'],
                      decoration: InputDecoration(labelText: 'book path'),
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      focusNode: _bookPathFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_coverPathFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter book path.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedBook = Book(
                          id: _editedBook.id,
                          title: _editedBook.title,
                          category: _editedBook.category,
                          authors: _editedBook.authors,
                          path: value,
                          coverPath: _editedBook.coverPath,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _coverPathController.text.isEmpty
                              ? Text('Enter cover image path')
                              : FittedBox(
                                  child: Image.asset(
                                    _coverPathController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Cover image path'),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            controller: _coverPathController,
                            focusNode: _coverPathFocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_submitButtonFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an cover image path.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid cover image path.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedBook = Book(
                                id: _editedBook.id,
                                title: _editedBook.title,
                                category: _editedBook.category,
                                authors: _editedBook.authors,
                                path: _editedBook.path,
                                coverPath: value,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    FlatButton(
                      onPressed: () {
                        _saveForm();
                      },
                      child: Text('Add Book'),
                      shape: StadiumBorder(),
                      color: Colors.pink,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
