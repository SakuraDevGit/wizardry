import 'dart:convert';
import 'package:data/models/elixir_model.dart';
import 'package:http/http.dart' as http;
import 'elixir_local_data_source.dart';
import 'package:domain/failures/failures.dart';

abstract class ElixirRemoteDataSource {
  Future<List<ElixirModel>> getElixirs();
}

class ElixirRemoteDataSourceImpl implements ElixirRemoteDataSource {
  final http.Client client;
  final ElixirLocalDataSource localDataSource;

  ElixirRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<List<ElixirModel>> getElixirs() async {
    final response = await client.get(
        Uri.parse('https://wizard-world-api.herokuapp.com/Elixirs'),
        headers: {'content-type': 'application/json'});

    if (response.statusCode != 200) {
      throw ServerFailure();
    }

    final responseBodyJson = jsonDecode(response.body);
    await localDataSource.saveElixirs(response.body);
    return responseBodyJson
        .map<ElixirModel>((elixir) => ElixirModel.fromJson(elixir))
        .toList();
  }
}
