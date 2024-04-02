import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wizarding_world/0_data/models/house_model.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';

abstract class HouseRemoteDataSource {
  Future<List<HouseModel>> getHouses();
}

class HouseRemoteDataSourceImpl implements HouseRemoteDataSource {
  final http.Client client;

  HouseRemoteDataSourceImpl({required this.client});

  @override
  Future<List<HouseModel>> getHouses() async {
    final response = await client.get(
        Uri.parse('https://wizard-world-api.herokuapp.com/Houses'),
        headers: {'content-type': 'application/json'});

    if (response.statusCode != 200) {
      throw ServerFailure();
    }

    final responseBodyJson = jsonDecode(response.body);
    return responseBodyJson
        .map<HouseModel>((house) => HouseModel.fromJson(house))
        .toList();
  }
}
