import 'package:audio_recorder/services/Models/recording.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'recordings_repository.dart';

class RecordingsProvider with ChangeNotifier {
  bool _isRecording = false;
  bool _isPlaying = false;

  FlutterSound _flutterSound = FlutterSound();
  var _playerSubscription;
  var _recordingSubscription;

  bool get getRecordingState => _isRecording;

  bool get getPlayState => _isPlaying;

  void setRecordingState(bool isRecording) {
    _isRecording = isRecording;
    _isPlaying = false;
    notifyListeners();
  }

  // this will turn into a database call in get recordings, wont need any of this
  List<Recording> _recordings = [];

  _fetchRecordingsFromDB() async {
    try {
      _recordings = await RecordingsRepository().getRecordings();
    } catch (e) {
      print("error getter getRecordings: " + e.toString());
    }
  }

  Future<List<Recording>> get getRecordings async {
    await _fetchRecordingsFromDB();
    return [..._recordings];
  }

  Recording findById(int _id) {
    return _recordings.firstWhere((recording) => recording.id == _id);
  }

  // this will turn into a database insert
  insertRecording(Recording _recording) async {
    _recordings.add(_recording);
    try {
      var success = await RecordingsRepository().insert(_recording);
      print("success insertingRecording? $success");
    } catch (e) {
      print("error insertingRecording: ${e.toString()}");
    }
    notifyListeners();
  }

  Future<String> _getAppDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  startRecording() async {
    Recording newRecording = Recording(
        createdAt: DateTime.now().toString(),
//        path: DateTime.now().toIso8601String()+".m4a",
        path: "testingtesting.m4a",
        title: "Hey is this work?");

    print("Starting recording");
    print("recording path: " + newRecording.path);

    await insertRecording(newRecording);
    print("new recording path after instert: " + newRecording.path);
    Future<String> result = _flutterSound
        .startRecorder(join(await _getAppDirectory(), newRecording.path));

    _isRecording = true;
    _isPlaying = false;

    notifyListeners();

    result.then((path) {
      print('startRecorder: $path');

      _recordingSubscription = _flutterSound.onRecorderStateChanged.listen((e) {
        DateTime date =
            new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
//        print("timestamp: $txt");
      });
    });
  }

  stopRecording() {
    print("stop recording");
    Future<String> result = _flutterSound.stopRecorder();

    _isRecording = false;
    _isPlaying = false;

    notifyListeners();

    result.then((value) {
      print('stopRecorder: $value');

      if (_recordingSubscription != null) {
        _recordingSubscription.cancel();
        _recordingSubscription = null;
      }
    });
  }

  playRecording(String path) async {
//    if(_flutterSound.isPlaying) _flutterSound.
    print("play recording in provider");
    String fullPath = join(await _getAppDirectory(), path);
    print("full path in play recording: $path");
    Future<String> result =
        _flutterSound.startPlayer(fullPath);

    _isPlaying = true;
    notifyListeners();

    result.then((path) {
      print('startPlayer: $path');

      _playerSubscription = _flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.currentPosition.toInt());
          String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
        }
      });
    });
  }
}
