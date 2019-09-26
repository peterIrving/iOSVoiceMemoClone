import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'daos/recording_dao.dart';

class DatabaseProvider {
  static final _instance = DatabaseProvider._internal();
  static DatabaseProvider get = _instance;
  bool isInitialized = false;
  Database _db;

  DatabaseProvider._internal();

  Future<Database> db() async {
    if (!isInitialized) await _init();
    return _db;
  }

  Future _init() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'audio_recorder.db');

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(RecordingDao().createTableQuery);
    });
  }
}
