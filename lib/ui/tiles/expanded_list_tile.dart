import 'package:audio_recorder/services/Models/recording.dart';
import 'package:audio_recorder/services/recording_services/recording_dao.dart';
import 'package:audio_recorder/services/recording_services/recording_provider.dart';
import 'package:audio_recorder/services/string_utilities.dart';
import 'package:audio_recorder/ui/tiles/playback_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpandedListTile extends StatefulWidget {
  final Recording recording;

  ExpandedListTile(this.recording);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExpandedListTileState();
  }
}

class _ExpandedListTileState extends State<ExpandedListTile> {

  RecordingState recordingState;

  @override
  void dispose() {
    if (recordingState.getPlayState == true) {
      print("Stopping playback");
      recordingState.stopPlayback();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    recordingState = Provider.of<RecordingState>(context);

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 15, right: 16),
            child: Row(
              children: <Widget>[
                Text(
                  widget.recording.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 2, right: 16),
            child: Row(
              children: <Widget>[
                Text(
                  formatTimestamp(widget.recording.createdAt),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  widget.recording.duration.substring(0, 5),
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Container(
              height: 38,
              child: PlaybackBar(widget.recording),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    print("taP");
                  },
                ),
                Expanded(
                  child: Container(),
                ),
                IconButton(
                  iconSize: 32,
                  icon: Icon(Icons.replay_10),
                  onPressed: () {
                    print("taP");
                  },
                ),
                IconButton(
                  iconSize: 50,
                  icon: Icon(recordingState.getPlayState
                      ? Icons.pause
                      : Icons.play_arrow),
                  onPressed: () {
                    if (recordingState.getPlayState == true) {
                      recordingState.stopPlayback();
                    } else {
                      recordingState.playRecording(widget.recording.path);
                    }
                  },
                ),
                IconButton(
                  iconSize: 32,
                  icon: Icon(Icons.forward_10),
                  onPressed: () {
                    print("taP");
                  },
                ),
                Expanded(
                  child: Container(),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print("taP");
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.grey,
            margin: EdgeInsets.symmetric(horizontal: 16),
          )
        ],
      ),
    );
  }
}
