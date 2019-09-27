import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class RecordingState with ChangeNotifier {
  RecordingState();

  bool _isRecording = false;
  bool _isPlaying = false;

  FlutterSound _flutterSound = FlutterSound();
  var _playerSubscription;
  var _recordingSubscription;

  void setRecordingState(bool isRecording) {
    _isRecording = isRecording;
    _isPlaying = false;
    notifyListeners();
  }

  bool get getRecordingState => _isRecording;

  bool get getPlayState => _isPlaying;

  Future<String> _getAppDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  startRecording(/*Function _insertRecording*/ String path) async {
    print("Starting recording");
    Future<String> result =
        _flutterSound.startRecorder(join(await _getAppDirectory(), path+".m4a"));

//    //TODO insert object into database
//    _insertRecording();

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

  playRecording() async {
    print("play recording in provider");
    Future<String> result =
        _flutterSound.startPlayer(join(await _getAppDirectory(), "test.m4a"));

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
