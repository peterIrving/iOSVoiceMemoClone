import 'package:audio_recorder/services/Models/recording.dart';
import 'package:audio_recorder/services/string_utilities.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  "00:00",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 5,),
                        Container(
                          height: 3,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      height: 14,
                    )
                  ],
                ),
              )),
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
