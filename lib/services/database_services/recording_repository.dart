import 'package:audio_recorder/services/Models/recording.dart';
import 'database_provider.dart';

abstract class RecordingRepository {
  DatabaseProvider databaseProvider;

  Future<Recording> insert(Recording note);

  Future<Recording> update(Recording note);

  Future<Recording> delete(Recording note);

  Future<List<Recording>> getRecordings();
}