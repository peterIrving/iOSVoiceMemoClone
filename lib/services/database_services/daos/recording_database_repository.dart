import 'package:audio_recorder/services/Models/recording.dart';
import 'package:audio_recorder/services/database_services/daos/recording_dao.dart';
import 'package:flutter/material.dart';
import '../database_provider.dart';
import '../recording_repository.dart';

class RecordingsDatabaseRepository with ChangeNotifier implements RecordingRepository  {
  final dao = RecordingDao();

  @override
  DatabaseProvider databaseProvider;

  RecordingsDatabaseRepository(this.databaseProvider);

  // todo find workflow that inserts recording into database, but then updates the UI as well
  // todo with a newly fetched array of recordings
  @override
  Future<Recording> insert(Recording recording) async {
    final db = await databaseProvider.db();
    recording.id = await db.insert(dao.tableName, dao.toMap(recording));
    return recording;
  }


  //todo delete and update repository
  @override
  Future<Recording> delete(Recording recording) async {
    final db = await databaseProvider.db();
    await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [recording.id]);
    return recording;
  }

  // todo update and update repository
  @override
  Future<Recording> update(Recording recording) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(recording),
        where: dao.columnId + " = ?", whereArgs: [recording.id]);
    return recording;
  }


  @override
  Future<List<Recording>> getRecordings() async {
    final db = await databaseProvider.db();
    List<Map> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}