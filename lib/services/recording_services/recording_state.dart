import 'package:audio_recorder/services/Models/recording.dart';
import 'package:audio_recorder/services/recording_services/recordings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class RecordingState with ChangeNotifier {
  RecordingState();

  bool _needsFetchingFromDb = true;

  List<Recording> _recordings = [];

//  List<Recording> get getRecordings {
//
//    return [..._recordings];
//  }

  Future<List<Recording>> get getRecordings async {
    print("get recordings called");
    if (_needsFetchingFromDb == true) {
      print("needs to fetch from db");
      await _fetchRecordingsFromDB();
      _needsFetchingFromDb = false;
    }
    print("Returning recordings");
    return [..._recordings];
  }

  _fetchRecordingsFromDB() async {
    try {
      _recordings = await RecordingsRepository().getRecordings();
    } catch (e) {
      print("error getter getRecordings: " + e.toString());
    }
  }

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

  int _getNewRecordingCount() {
    int unnamedCount = 1;
    _recordings.forEach((recording) {
      if (recording.title.contains("newRecording")) {
        unnamedCount += 1;
      }
    });
    return unnamedCount;
  }

  startRecording() async {
    print("Starting recording");

    var createdAt = DateTime.now().toIso8601String();

    var fullPath = join(await _getAppDirectory(), createdAt + ".m4a");

    final newRecording = Recording(
      path: fullPath,
      createdAt: createdAt,
      title: "newRecording ${_getNewRecordingCount()}",
      notes: "",
    );

    Future<String> result = _flutterSound.startRecorder(fullPath);

    _recordings.insert(0, newRecording);
    _isRecording = true;
    _isPlaying = false;

    notifyListeners();

    // todo handle a failed insert - notify ui and remove object
    RecordingsRepository().insert(newRecording);

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
    print("play recording in provider");
    Future<String> result =
        _flutterSound.startPlayer(path);

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
