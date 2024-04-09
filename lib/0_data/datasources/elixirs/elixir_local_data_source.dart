import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wizarding_world/0_data/hive/hive_constants.dart';
import 'package:wizarding_world/0_data/hive/stored_json_hive.dart';
import 'package:wizarding_world/0_data/models/elixir_model.dart';
import 'package:wizarding_world/1_domain/entities/elixir_entities/elixir_entity.dart';

class ElixirLocalDataSource {
  Future<void> saveElixirs(String elixirsJsonString) async {
    var box = await Hive.openBox<StoredJSON>(HiveConstants.storedJSONBox);
    box.put(HiveConstants.elixirsJSONKey,
        StoredJSON(timeStamp: DateTime.now(), json: elixirsJsonString));
  }

  Future<List<ElixirEntity>> getElixirs() async {
    var box = await Hive.openBox<StoredJSON>(HiveConstants.storedJSONBox);
    final value = box.get(HiveConstants.elixirsJSONKey);

    if (value == null) {
      return [];
    }

    DateTime fiveMinutesAgo =
        DateTime.now().subtract(const Duration(minutes: 5));
    bool isOlderThanFiveMinutes = value.timeStamp.isBefore(fiveMinutesAgo);

    if (isOlderThanFiveMinutes) {
      return [];
    }

    try {
      final contents = value.json;
      final List<dynamic> elixirsJsonList = await jsonDecode(contents);
      return elixirsJsonList.map((json) => ElixirModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
