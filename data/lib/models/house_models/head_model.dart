import 'package:domain/entities/house_entities/head_entity.dart';

class HeadModel extends HeadEntity {
  HeadModel({
    required super.id,
    required super.firstName,
    required super.lastName,
  });

  factory HeadModel.fromJson(Map<String, dynamic> json) {
    return HeadModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
