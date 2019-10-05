import 'package:audio_recorder/services/recording_services/recording_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RecordingListTile extends StatefulWidget {
  final int id;
  bool isExpanded = false;

  RecordingListTile(this.id);

  @override
  _RecordingListTileState createState() => _RecordingListTileState();
}

class _RecordingListTileState extends State<RecordingListTile> {


  _changeExpansionState() {
    setState(() {
      widget.isExpanded = !widget.isExpanded;
    });
  }

  String _formatTimestamp(String dateString) {
    DateTime time = DateTime.parse(dateString);
    return DateFormat.yMMMd('en_US').add_jm().format(time).toString();
  }

  @override
  Widget build(BuildContext context) {
    print("build called");

    final _recordingState = Provider.of<RecordingState>(context);
    final _recording = _recordingState.getRecordingForId(widget.id);

    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      height: widget.isExpanded ? 200 : 50,
      child: widget.isExpanded
          ? GestureDetector(
              onTap: () {
                print("tapped");
                _changeExpansionState();
              },
              child: ExpandedListTile())
          : ListTile(
              title: Text(_recording.title),
              subtitle: Text(_formatTimestamp(_recording.createdAt)),
              onTap: () {
                print("tile clicked");
//          print("path ${_recording.path}");
//          _recordingState.playRecording(_recording.path);
                _changeExpansionState();
              },
            ),
    );

//    if (isExpanded) {
//      return GestureDetector(
//        onTap: () {
//          print("tapped");
//          _changeExpansionState();
//        },
//        child: Container(
//          height: 200,
//          color: Colors.red,
//        ),
//      );
//    } else {
//      return ListTile(
//        title: Text(_recording.title),
//        subtitle: Text(_formatTimestamp(_recording.createdAt)),
//        onTap: () {
//          print("tile clicked");
////          print("path ${_recording.path}");
////          _recordingState.playRecording(_recording.path);
//          _changeExpansionState();
//        },
//      );
//    }
  }
}

class ExpandedListTile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExpandedListTileState();
  }
}

class _ExpandedListTileState extends State<ExpandedListTile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
            child: Row(
              children: <Widget>[
                Text(
                  "title",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8, right: 12),
            child: Row(
              children: <Widget>[
                Text(
                  "Date",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Container(),
                ),
                Text("00:00", style: TextStyle(fontSize: 16))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.red,
              height: 35,
              child: Center(
                child: Text("time bar, display and manage playback state"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    print("taP");
                  },
                ),
                Expanded(child: Container(),),
                IconButton(
                  iconSize: 32,
                  icon: Icon(Icons.replay_10),
                  onPressed: () {
                    print("taP");
                  },
                ),
                IconButton(
                  iconSize: 50,
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    print("taP");
                  },
                ),
                IconButton(
                  iconSize: 32,
                  icon: Icon(Icons.forward_10),
                  onPressed: () {
                    print("taP");
                  },
                ),
                Expanded(child: Container(),),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print("taP");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
