import 'package:audio_recorder/services/recording_services/recording_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HalfTabRecordingDetails extends StatefulWidget {
  @override
  _HalfTabRecordingDetailsState createState() =>
      _HalfTabRecordingDetailsState();
}

class _HalfTabRecordingDetailsState extends State<HalfTabRecordingDetails> {
  @override
  Widget build(BuildContext context) {
    var recordingState = Provider.of<RecordingState>(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 12),
          child: Text(
            recordingState.getCurrentRecording.title,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        Container(
            child: Text(
              recordingState.getCurrentTime,
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),

      ],
    );
  }
}
