import 'package:audio_recorder/ios_version/recording_list_page.dart';
import 'package:audio_recorder/services/recording_services/recording_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/database_services/daos/recording_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
//        ChangeNotifierProvider<RecordingsProvider>.value(
//          notifier: RecordingState(),
//        ),
        ChangeNotifierProvider<RecordingsProvider>.value(
          notifier: RecordingsProvider(),
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
