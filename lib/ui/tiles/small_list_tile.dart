import 'package:audio_recorder/services/Models/recording.dart';
import 'package:audio_recorder/services/recording_services/recording_provider.dart';
import 'package:audio_recorder/services/string_utilities.dart';
import 'package:audio_recorder/ui/recording_list/recording_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SmallListTile extends StatelessWidget {
  final Recording recording;
  final int index;

  SmallListTile(this.recording, this.index);

  @override
  Widget build(BuildContext context) {
    var listState = Provider.of<RecordingListProvider>(context);
    var recordingState = Provider.of<RecordingState>(context);

    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            recording.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          subtitle: Row(
            children: <Widget>[
              Text(
                formatTimestamp(recording.createdAt),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                recording.duration == null
                    ? recordingState.getCurrentTime.substring(0, 5)
                    : recording.duration.substring(0, 5),
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )
            ],
          ),
          onTap: () {
            listState.setSelectedIndex = index;
          },
        ),
        Container(
          height: 0.5,
          color: Colors.grey,
          margin: EdgeInsets.symmetric(horizontal: 16),
        )
      ],
    );
  }
}
