import 'dart:convert';
import 'package:data/hive/hive_constants.dart';
import 'package:data/hive/stored_json_hive.dart';
import 'package:data/models/house_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HouseLocalDataSource {
  Future<List<HouseModel>> getHouses();
  Future<void> saveHouses(String housesJsonString);
}

class HouseLocalDataSourceImpl implements HouseLocalDataSource {
  @override
  Future<void> saveHouses(String housesJsonString) async {
    var box = await Hive.openBox<StoredJSON>(HiveConstants.storedJSONBox);
    box.put(HiveConstants.housesJSONKey,
        StoredJSON(timeStamp: DateTime.now(), json: housesJsonString));
  }

  @override
  Future<List<HouseModel>> getHouses() async {
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
