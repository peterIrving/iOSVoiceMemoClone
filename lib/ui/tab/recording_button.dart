import 'package:audio_recorder/services/recording_services/recording_provider.dart';
import 'package:audio_recorder/ui/recording_list/recording_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AnimatedButton({Key key, this.onPressed}) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    final recordingsProvider = Provider.of<RecordingState>(context);
    bool _isRecording = recordingsProvider.getRecordingState;

    final listProvider = Provider.of<RecordingListProvider>(context);

    double buttonRadius = _isRecording ? 32 : 70;
    ShapeBorder shapeBorder = _isRecording
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          )
        : CircleBorder();

    return Center(
      child: AnimatedContainer(
        curve: _isRecording ? Curves.easeOutQuart : Curves.easeInQuad,
        duration: Duration(milliseconds: 300),
        height: buttonRadius,
        width: buttonRadius,
        child: FloatingActionButton(
            shape: shapeBorder,
            backgroundColor: Colors.red,
            onPressed: () {
              listProvider.setSelectedIndex = -1;
              widget.onPressed();
            }),
      ),
    );
  }
}
