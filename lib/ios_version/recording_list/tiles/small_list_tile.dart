import 'package:audio_recorder/services/Models/recording.dart';
import 'package:audio_recorder/services/string_utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../recording_list_provider.dart';

class SmallListTile extends StatelessWidget {
  final Recording recording;
  final int index;

  SmallListTile(this.recording, this.index);

  @override
  Widget build(BuildContext context) {
    var listState = Provider.of<RecordingListProvider>(context);

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
          subtitle: Text(
            formatTimestamp(recording.createdAt),
          ),
          onTap: () {
            print("selected index = $index");
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
