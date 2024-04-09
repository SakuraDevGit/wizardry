import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wizarding_world/0_data/hive/hive_constants.dart';
import 'package:wizarding_world/0_data/hive/stored_json_hive.dart';
import 'package:wizarding_world/0_data/models/spell_model.dart';
import 'package:wizarding_world/1_domain/entities/spell_entities/spell_entity.dart';

class SpellLocalDataSource {
  Future<void> saveSpells(String spellsJsonString) async {
    var box = await Hive.openBox<StoredJSON>(HiveConstants.storedJSONBox);
    box.put(HiveConstants.spellsJSONKey,
        StoredJSON(timeStamp: DateTime.now(), json: spellsJsonString));
  }

  Future<List<SpellEntity>> getSpells() async {
    var box = await Hive.openBox<StoredJSON>(HiveConstants.storedJSONBox);
    final value = box.get(HiveConstants.spellsJSONKey);

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
      final List<dynamic> spellsJsonList = await jsonDecode(contents);
      return spellsJsonList.map((json) => SpellModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
