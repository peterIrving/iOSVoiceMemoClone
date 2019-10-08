import 'package:audio_recorder/services/Models/recording.dart';
import 'package:audio_recorder/services/database_services/dao.dart';

class RecordingDao implements Dao<Recording> {
  final tableName = "recordings";
  final columnId = "id";
  final _columnTitle = "title";
  final _columnNotes = "notes";
  final columnPath = "path";
  final _columnCreatedAt = "created_at";
  final _columnUpdatedAt = "updated_at";
  final _columnDuration = "duration";

  @override
  // TODO: implement createTableQuery
  String get createTableQuery {
    return """
      CREATE TABLE $tableName(
        $_columnTitle TEXT,
        $_columnNotes TEXT,
        $columnPath TEXT,
        $_columnCreatedAt DATE,
        $_columnUpdatedAt DATE,
        $_columnDuration TEXT)
    """;
  }
  //        $columnId INTEGER PRIMARY KEY,


  @override
  List<Recording> fromList(List<Map<String, dynamic>> query) {
    List<Recording> recordings = List<Recording>();
    for (Map map in query) {
      recordings.add(fromMap(map));
    }
    return recordings;
  }

  @override
  Recording fromMap(Map<String, dynamic> query) {
    Recording recording = Recording();

//    recording.id = query[columnId];
    recording.title = query[_columnTitle];
    recording.notes = query[_columnNotes];
    recording.createdAt = query[_columnCreatedAt];
    recording.path = query[columnPath];
    recording.updatedAt = query[_columnUpdatedAt];
    recording.duration = query[_columnDuration];

    return recording;
  }

  @override
  Map<String, dynamic> toMap(Recording object) {
    return <String, dynamic>{
//      columnId: object.id,
      _columnTitle: object.title,
      _columnNotes: object.notes,
      columnPath: object.path.toString(),
      _columnCreatedAt: object.createdAt.toString(),
      _columnUpdatedAt: object.updatedAt.toString(),
      _columnDuration: object.duration.toString()
    };
  }
}
