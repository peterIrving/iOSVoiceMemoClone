import 'package:flutter/material.dart';

class Recording with ChangeNotifier {
  String title;
  String notes;
  String path;
  String createdAt;
  String updatedAt;
  String duration;


  Recording({
    @required this.path,
    @required this.createdAt,
    this.title = "untitled",
    this.notes = "enter some data",
  });

}