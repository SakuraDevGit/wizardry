import 'package:data/hive/stored_json_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveWrapper {
  static Future<void> initFlutter() {
    return Hive.initFlutter();
  }

  static void registerWrappers() {
    Hive.registerAdapter(StoredJSONAdapter());
  }
}
