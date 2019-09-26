import 'package:flutter/foundation.dart';

class Recordings with ChangeNotifier {

  // this will turn into a database call in get recordings, wont need any of this
  List<Recording> _recordings = [
//    Recording(id: 0, createdAt: DateTime.now(), path: "sound.m4a"),
//    Recording(id: 0, createdAt: DateTime.now(), path: "sound.m4a"),
//    Recording(id: 0, createdAt: DateTime.now(), path: "sound.m4a"),
//    Recording(id: 0, createdAt: DateTime.now(), path: "sound.m4a"),
//    Recording(id: 0, createdAt: DateTime.now(), path: "sound.m4a"),
//    Recording(id: 0, createdAt: DateTime.now(), path: "sound.m4a"),
//    Recording(id: 0, createdAt: DateTime.now(), path: "sound.m4a"),
//    Recording(id: 0, createdAt: DateTime.now(), path: "sound.m4a"),
  ];

  List<Recording> get getRecordings {
    return [..._recordings];
  }

  Recording findById(int _id) {
    return _recordings.firstWhere((recording) => recording.id == _id);
  }

  // this will turn into a database insert
  addRecording(Recording _recording) {
    _recordings.add(_recording);
    notifyListeners();
  }


}

class Recording with ChangeNotifier {
  final int id;
  String title;
  String notes;
  final String path;
  final DateTime createdAt;
  DateTime updatedAt;

  Recording({
    this.id,
    @required this.path,
    @required this.createdAt,
    this.title = "untitled",
    this.notes = "enter some data",
  });



}
