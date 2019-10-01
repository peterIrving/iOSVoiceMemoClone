import 'package:audio_recorder/services/database_services/daos/recording_provider.dart';
import 'package:audio_recorder/services/recording_services/recording_state.dart';
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
    final recordingsProvider = Provider.of<RecordingsProvider>(context);
    bool _isRecording = recordingsProvider.getRecordingState;

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
              widget.onPressed();
            }),
      ),
    );
  }
}
