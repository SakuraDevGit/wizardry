import 'package:dartz/dartz.dart';
import 'package:domain/entities/house_entities/house_entity.dart';
import 'package:domain/failures/failures.dart';

abstract class HouseRepository {
  Future<Either<WizardingFailure, List<HouseEntity>>> getHouses();
}
