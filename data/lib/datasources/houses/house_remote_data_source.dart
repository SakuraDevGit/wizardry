import 'dart:convert';

import 'package:data/models/house_models/house_model.dart';
import 'package:http/http.dart' as http;
import 'house_local_data_source.dart';
import 'package:domain/failures/failures.dart';

abstract class HouseRemoteDataSource {
  Future<List<HouseModel>> getHouses();
}

class HouseRemoteDataSourceImpl implements HouseRemoteDataSource {
  final http.Client client;
  final HouseLocalDataSource localDataSource;

  HouseRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<List<HouseModel>> getHouses() async {
    final response = await client.get(
        Uri.parse('https://wizard-world-api.herokuapp.com/Houses'),
        headers: {'content-type': 'application/json'});

    if (response.statusCode != 200) {
      throw ServerFailure();
    }

    final responseBodyJson = jsonDecode(response.body);
    await localDataSource.saveHouses(response.body);
    return responseBodyJson
        .map<HouseModel>((house) => HouseModel.fromJson(house))
        .toList();
  }
}
