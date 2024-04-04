import 'dart:convert';
import 'dart:io';
import 'package:wizarding_world/0_data/models/spell_model.dart';
import 'package:wizarding_world/1_domain/entities/spell_entities/spell_entity.dart';
import 'package:path_provider/path_provider.dart';

class SpellLocalDataSource {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/spells.json');
  }

  Future<File> saveSpells(String spellsJsonString) async {
    final file = await _localFile;
    return file.writeAsString(spellsJsonString);
  }

  Future<List<SpellEntity>> getSpells() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final List<dynamic> spellsJsonList = await jsonDecode(contents);
      return spellsJsonList.map((json) => SpellModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
