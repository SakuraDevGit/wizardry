import 'package:hive/hive.dart';
part 'stored_json_hive.g.dart';

@HiveType(typeId: 1)
class StoredJSON {
  StoredJSON({required this.timeStamp, required this.json});

  @HiveField(0)
  DateTime timeStamp;

  @HiveField(1)
  String json;

  @override
  String toString() {
    return '$timeStamp: $json';
  }
}
