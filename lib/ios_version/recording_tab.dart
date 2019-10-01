import 'package:audio_recorder/ios_version/recording_button.dart';
import 'package:audio_recorder/services/Models/recording.dart';
import 'package:audio_recorder/services/database_services/daos/recording_provider.dart';
import 'package:audio_recorder/services/recording_services/recording_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:provider/provider.dart';

class RecordingTab extends StatefulWidget {
  @override
  _RecordingTabState createState() => _RecordingTabState();
}

class _RecordingTabState extends State<RecordingTab> {
  FlutterSound flutterSound = new FlutterSound();

  RecordingsProvider recordingsProvider;

  @override
  void dispose() {
    flutterSound.stopRecorder();
    super.dispose();
  }

  toggleRecording(RecordingsProvider state) {
    print("state in toggleRecording: ${state.getRecordingState}");

    if (state.getRecordingState == true) {
      state.startRecording();
    } else {
      state.stopRecording();
    }
  }

  Widget _buildTabBar(double height, double screenWidth, double buttonRadius,
      double bottomConstraint) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: AnimatedContainer(
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        color: Colors.black,
        height: height,
        width: screenWidth,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(80)),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 3),
                      borderRadius: BorderRadius.circular(80)),
                  height: buttonRadius,
                  width: buttonRadius,
//                child: FittedBox(
//                  child: FloatingActionButton(
//                    shape: CircleBorder(),
//                    onPressed: _toggleRecording,
//                  ),
//                ),
                  child: AnimatedButton(
                    onPressed: () {
                      recordingsProvider
                          .setRecordingState(!recordingsProvider.getRecordingState);
                      toggleRecording(recordingsProvider);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: bottomConstraint,
              )
            ],
          ),
        ),
      ),
    );
  }

  double initialY = 0;
  double heightChange = 0;

  @override
  Widget build(BuildContext context) {
    recordingsProvider = Provider.of<RecordingsProvider>(context);
//    recordingRepository = Provider.of<RecordingsDatabaseRepository>(context);
    bool isRecording = recordingsProvider.getRecordingState;

    double screenWidth = MediaQuery.of(context).size.width;
    double height = isRecording ? 300 : 100;
    double buttonRadius = 60;
    double bottomConstraint = 15;

    return GestureDetector(
//      onPanDown: _isRecording
//          ? (DragDownDetails details) {
//              print("starting y" + details.globalPosition.dy.toString());
//              initialY = details.globalPosition.dy;
//            }
//          : null,
//      onPanUpdate: _isRecording
//          ? (DragUpdateDetails details) {
//              setState(() {
//                if ((details.globalPosition.dy - initialY).abs() > 0) {
//                  heightChange = (details.globalPosition.dy - initialY).abs();
//                }
//              });
//            }
//          : null,
      onPanEnd: (DragEndDetails details) {
        double velocity = details.velocity.pixelsPerSecond.dy;
        print("velocity: $velocity");
        if (velocity < 2000 && isRecording) {
          setState(() {
            heightChange = MediaQuery.of(context).size.height - height - 35;
            print("height change: $heightChange");
          });
        } else if (velocity > 2000 && isRecording) {
          setState(() {
            heightChange = 0;
          });
        }
      },
      child: _buildTabBar(
          height + heightChange, screenWidth, buttonRadius, bottomConstraint),
    );
  }
}
