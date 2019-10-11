import 'package:audio_recorder/services/Models/recording.dart';
import 'package:audio_recorder/services/recording_services/recording_provider.dart';
import 'package:audio_recorder/ui/recording_list/recording_list_provider.dart';
import 'package:audio_recorder/ui/tab/recording_tab.dart';
import 'package:audio_recorder/ui/tiles/expanded_list_tile.dart';
import 'package:audio_recorder/ui/tiles/small_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class RecordingListPage extends StatefulWidget {
  @override
  _RecordingListPageState createState() => _RecordingListPageState();
}

class _RecordingListPageState extends State<RecordingListPage> {
  FlutterSound flutterSound = FlutterSound();

  // initState get provider to load items from db

  @override
  initState() {
    super.initState();

    // check permissions
    _checkPermissions();
  }

  _checkPermissions() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.microphone, PermissionGroup.storage]);
  }

  Widget _buildCustomAppBar() {
    return SliverAppBar(
      elevation: 3,
      backgroundColor: Colors.grey.shade300,
      expandedHeight: 90.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.fromLTRB(16, 24, 50, 20),
        centerTitle: false,
        title: Text(
          "Recordings",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
          ),
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

  Widget _buildCustomListView(
      RecordingState recordingState, BuildContext context) {
    final _recordings = recordingState.getRecordings;
    final _recordingListState = Provider.of<RecordingListProvider>(context);

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

                      if (index == _recordingListState.selectedIndex) {
                        return ExpandedListTile(_recording);
                      } else {
                        return SmallListTile(_recording, index);
                      }
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
  }

  @override
  Widget build(BuildContext context) {
    final recordingState = Provider.of<RecordingState>(context);
    bool _isRecording = recordingState.getRecordingState;

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
            ],
          ),
        ],
      ),
    );
  }
}
