import 'package:audio_recorder/services/Models/recording.dart';
import 'package:audio_recorder/services/recording_services/recording_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaybackBar extends StatefulWidget {
  final Recording recording;

  PlaybackBar(this.recording);

  @override
  _PlaybackBarState createState() => _PlaybackBarState();
}

class _PlaybackBarState extends State<PlaybackBar> {
  GlobalKey _keyCircle = GlobalKey();
  GlobalKey _durationBarKey = GlobalKey();

  var barWidth;

  _getSizes(_) {
    final RenderBox renderBoxRed = _durationBarKey.currentContext.findRenderObject();
//    final sizeCircle = renderBoxRed.size;
//    final positionCircle = renderBoxRed.localToGlobal(Offset.zero);
    print("width of bar = " + renderBoxRed.size.width.toString());
    barWidth = renderBoxRed.size.width - 14;

//    print("SIZE of circle: $sizeCircle");
//    print("Position of cicle: $positionCircle");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_getSizes);
  }

  @override
  Widget build(BuildContext context) {
    final recordingState = Provider.of<RecordingState>(context);


    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Container(
                  key: _durationBarKey,
                  height: 3,
                  color: Colors.grey.shade300,
                ),
                SizedBox(
                  height: 6,
                ),
              ],
            ),
            Positioned(
              left: barWidth,
              child: Container(
                key: _keyCircle,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                height: 14,
                width: 14,
              ),
            )
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: <Widget>[
            Text("00:00"),
            Expanded(
              child: Container(),
            ),
            Text("-" + widget.recording.duration.substring(0, 5))
          ],
        )
      ],
    );
  }
}
