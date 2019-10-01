import 'package:audio_recorder/services/Models/recording.dart';
import 'package:audio_recorder/services/database_services/database_provider.dart';
import 'package:audio_recorder/services/recording_services/recording_dao.dart';

class RecordingsRepository {
  final dao = RecordingDao();

//  DatabaseProvider databaseProvider;
  DatabaseHelper databaseHelper = DatabaseHelper();

//  RecordingsDatabaseRepository(this.databaseProvider);

  // todo find workflow that inserts recording into database, but then updates the UI as well
  // todo with a newly fetched array of recordings
  Future<int> insert(Recording recording) async {
    final db = await databaseHelper.database;
    print(dao.toMap(recording).toString());
    var success = await db.insert(dao.tableName, dao.toMap(recording));
    return success;
  }


  //todo delete and update repository
  Future<Recording> delete(Recording recording) async {
    final db = await databaseHelper.database;
    await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [recording.id]);
    return recording;
  }

  // todo update and update repository
  Future<Recording> update(Recording recording) async {
    final db = await databaseHelper.database;
    await db.update(dao.tableName, dao.toMap(recording),
        where: dao.columnId + " = ?", whereArgs: [recording.id]);
    return recording;
  }

  Future<List<Recording>> getRecordings() async {
    final db = await databaseHelper.database;
    List<Map> maps = await db.rawQuery("SELECT * FROM ${dao.tableName} ORDER BY created_at DESC");
    return dao.fromList(maps);
  }

//  Future<List<Recording>> get recordings async {
//    return getRecordings();
//  }

}
