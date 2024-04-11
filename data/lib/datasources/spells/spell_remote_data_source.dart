import 'dart:convert';
import 'package:data/models/spell_model.dart';
import 'package:http/http.dart' as http;
import 'spell_local_data_source.dart';
import 'package:domain/failures/failures.dart';

abstract class SpellRemoteDataSource {
  Future<List<SpellModel>> getSpells();
  Future<List<SpellModel>> getSpellsWith(
      String name, String type, String incantation);
}

class SpellRemoteDataSourceImpl implements SpellRemoteDataSource {
  final http.Client client;
  final SpellLocalDataSource localDataSource;

  SpellRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<List<SpellModel>> getSpells() async {
    final response = await client.get(
        Uri.parse('https://wizard-world-api.herokuapp.com/Spells'),
        headers: {'content-type': 'application/json'});

    if (response.statusCode != 200) {
      throw ServerFailure();
    }

    final responseBodyJson = jsonDecode(response.body);
    await localDataSource.saveSpells(response.body);
    return responseBodyJson
        .map<SpellModel>((spell) => SpellModel.fromJson(spell))
        .toList();
  }

  @override
  Future<List<SpellModel>> getSpellsWith(
      String name, String type, String incantation) async {
    final response = await client.get(
        Uri.parse(
            'https://wizard-world-api.herokuapp.com/Spells?Name=$name&Type=$type&Incantation=$incantation'),
        headers: {'content-type': 'application/json'});

    if (response.statusCode != 200) {
      throw ServerFailure();
    }

    final responseBodyJson = jsonDecode(response.body);
    return responseBodyJson
        .map<SpellModel>((spell) => SpellModel.fromJson(spell))
        .toList();
  }
}
