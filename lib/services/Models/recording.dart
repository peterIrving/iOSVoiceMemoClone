import 'package:flutter/material.dart';

class Recording with ChangeNotifier {
  int id;
  String title;
  String notes;
  String path;
  String createdAt;
  String updatedAt;

  Recording({
    this.id,
    @required this.path,
    @required this.createdAt,
    this.title = "untitled",
    this.notes = "enter some data",
  });

}