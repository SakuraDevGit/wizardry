import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wizarding_world/0_data/hive/hive_constants.dart';
import 'package:wizarding_world/0_data/hive/stored_json_hive.dart';
import 'package:wizarding_world/0_data/models/house_model.dart';
import 'package:wizarding_world/1_domain/entities/house_entities/house_entity.dart';

class HouseLocalDataSource {
  Future<void> saveHouses(String housesJsonString) async {
    var box = await Hive.openBox<StoredJSON>(HiveConstants.storedJSONBox);
    box.put(HiveConstants.housesJSONKey,
        StoredJSON(timeStamp: DateTime.now(), json: housesJsonString));
  }

  Future<List<HouseEntity>> getHouses() async {
    var box = await Hive.openBox<StoredJSON>(HiveConstants.storedJSONBox);
    final value = box.get(HiveConstants.housesJSONKey);

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
      final List<dynamic> housesJsonList = await jsonDecode(contents);
      return housesJsonList.map((json) => HouseModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
