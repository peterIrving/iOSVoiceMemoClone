import 'package:audio_recorder/ios_version/recording_list/recording_list_page.dart';
import 'package:audio_recorder/services/recording_services/recording_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RecordingState>.value(
          notifier: RecordingState(),
        ),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RecordingListPage(),
      ),
    );
  }
}
