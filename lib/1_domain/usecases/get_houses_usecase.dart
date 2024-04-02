import 'package:dartz/dartz.dart';
import 'package:wizarding_world/0_data/repositories/house_repository_impl.dart';
import 'package:wizarding_world/1_domain/entities/house_entities/house_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';
import 'package:wizarding_world/1_domain/repositories/house_repository.dart';

class GetHousesUseCase {
  final HouseRepository houseRepository;

  GetHousesUseCase({required this.houseRepository});

  Future<Either<Failure, List<HouseEntity>>> getHouses() {
    return houseRepository.getHouses();
  }
}
