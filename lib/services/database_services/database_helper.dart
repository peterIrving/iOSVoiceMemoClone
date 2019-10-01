import 'package:audio_recorder/services/recording_services/recording_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/audio_recorder.db';

    var database = await openDatabase(
      path,
      version: 6,
      onCreate: _createDb,
      onUpgrade: _upgradeDb,
    );
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    print('creating database');
    db.execute(RecordingDao().createTableQuery);
  }

  void _upgradeDb(Database db, int oldVersion, int newVersion) async {
    print('upgrading db');
  }

}
