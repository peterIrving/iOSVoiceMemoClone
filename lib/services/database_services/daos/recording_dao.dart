import 'package:audio_recorder/services/Models/recording.dart';
import 'dao.dart';

class RecordingDao implements Dao<Recording> {
  final tableName = "recordings";
  final columnId = "id";
  final _columnTitle = "title";
  final _columnNotes = "notes";
  final _columnPath = "path";
  final _columnCreatedAt = "created_at";
  final _columnUpdatedAt = "updated_at";

  @override
  // TODO: implement createTableQuery
  String get createTableQuery {
    return """
      CREATE TABLE $tableName(
        $columnId INTEGER PRIMARY KEY,
        $_columnTitle TEXT,
        $_columnNotes TEXT,
        $_columnPath TEXT,
        $_columnCreatedAt DATE,
        $_columnUpdatedAt DATE)
    """;
  }

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

    recording.id = query[columnId];
    recording.title = query[_columnTitle];
    recording.notes = query[_columnNotes];
    recording.createdAt = query[_columnCreatedAt];
    recording.title = query[_columnTitle];
    recording.updatedAt = query[_columnUpdatedAt];

    return recording;
  }

  @override
  Map<String, dynamic> toMap(Recording object) {
    return <String, dynamic>{
      columnId: object.id,
      _columnTitle: object.title,
      _columnNotes: object.notes,
      _columnPath: object.path.toString(),
      _columnCreatedAt: object.createdAt.toString(),
      _columnUpdatedAt: object.updatedAt.toString(),
    };
  }
}
