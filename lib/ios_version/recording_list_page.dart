import 'package:audio_recorder/ios_version/recording_tab.dart';
import 'package:audio_recorder/services/Models/recording.dart';
import 'package:audio_recorder/services/database_services/daos/recording_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RecordingListPage extends StatefulWidget {
  @override
  _RecordingListPageState createState() => _RecordingListPageState();
}

class _RecordingListPageState extends State<RecordingListPage> {
  FlutterSound flutterSound = FlutterSound();

  Widget _buildCustomAppBar() {
    return SliverAppBar(
      elevation: 3,
      backgroundColor: Colors.black12,
      expandedHeight: 90.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.fromLTRB(16, 24, 50, 20),
        centerTitle: false,
        title: Text(
          "Recordings",
          style: TextStyle(
              color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w700),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 6),
          child: Text(
            "Edit",
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
        ),
      ],
    );
  }

  String _formatTimestamp(String dateString) {
    DateTime time = DateTime.parse(dateString);
    return DateFormat.yMMMd('en_US').add_jm().format(time).toString();
  }

  Widget _buildCustomListView(
      RecordingsProvider recordingState, BuildContext context) {
    final _recordings = Provider.of<RecordingsProvider>(context).getRecordings;

    return FutureBuilder(
      future: _recordings,
      builder: (context, AsyncSnapshot<List<Recording>> snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              _buildCustomAppBar(),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 100.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final _recording = snapshot.data[index];
//                      final _recording = _recordings[index];
                      return ListTile(
                        title: Text(_recording.path ?? "test"),
                        subtitle: Text(_formatTimestamp(_recording.createdAt)),
                        onTap: () {
                          print("tile clicked");
                          print("path ${_recording.path}");
                          recordingState.playRecording("testingtesting.m4a");
                        },
                      );
                    },
                    childCount: snapshot.data.length,
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          print('error');
          return CustomScrollView(
            slivers: <Widget>[
              _buildCustomAppBar(),
              SliverFillRemaining(
                child: Center(child: Text("error")),
              ),
            ],
          );
        } else {
          return CustomScrollView(
            slivers: <Widget>[
              _buildCustomAppBar(),
              SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        }
      },
    );
//    return CustomScrollView(slivers: <Widget>[
//      _buildCustomAppBar(),
//      SliverPadding(
//        padding: const EdgeInsets.only(bottom: 100.0),
//        sliver: SliverList(
//          delegate: SliverChildBuilderDelegate(
//            (BuildContext context, int index) {
//              final _recording = snapshot.data[index];
////                      final _recording = _recordings[index];
//              return ListTile(
//                title: Text(_recording.title),
//                subtitle: Text(_formatTimestamp(_recording.createdAt)),
//                onTap: () {
//                  print("tile clicked");
//                  recordingState.playRecording();
//                },
//              );
//            },
//            childCount: snapshot.data.length,
//          ),
//        ),
//      ),
//    ]);
  }

  @override
  Widget build(BuildContext context) {
    final recordingState = Provider.of<RecordingsProvider>(context);
//    final _recordings = Provider.of<RecordingsDatabaseRepository>(context);
    bool _isRecording = recordingState.getRecordingState;

    print("isRecording: $_isRecording");

    return Scaffold(
      body: Stack(
        children: <Widget>[
          IgnorePointer(
            ignoring: _isRecording,
            child: _isRecording
                ? Container(
                    color: Colors.black45,
                    child: _buildCustomListView(recordingState, context),
                  )
                : _buildCustomListView(recordingState, context),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              RecordingTab()
//              AnimatedButton(onPressed: () {
//                recordingState.setRecordingState(!recordingState.getRecordingState);
//                toggleRecording(recordingState, _recordings); },)
            ],
          ),
        ],
      ),
    );
  }

//  toggleRecording(RecordingState state, Recordings recordings) {
//    print("state in toggleRecording: ${state.getRecordingState}");
//
//    Recording recording = Recording(
//        createdAt: DateTime.now(),
//        path: DateTime.now().toString(),
//        title: "Hey is this work?"
//    );
//
//    if (state.getRecordingState == true) {
//      state.startRecording(recordings.addRecording(recording), recording.createdAt.toString() );
//    } else {
//      state.stopRecording();
//    }
//  }
}
