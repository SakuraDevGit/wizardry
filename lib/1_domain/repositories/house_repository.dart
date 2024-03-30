import 'package:dartz/dartz.dart';
import 'package:wizarding_world/1_domain/entities/house_entities/house_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';

abstract class HouseRepository {
  Future<Either<Failure, List<HouseEntity>>> getHouses();
}
