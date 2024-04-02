import 'package:dartz/dartz.dart';
import 'package:wizarding_world/0_data/datasources/house_remote_data_source.dart';
import 'package:wizarding_world/1_domain/entities/house_entities/house_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';
import 'package:wizarding_world/1_domain/repositories/house_repository.dart';

class HouseRepositoryImpl implements HouseRepository {
  final HouseRemoteDataSource remoteDataSource;

  HouseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HouseEntity>>> getHouses() async {
    try {
      final houses = await remoteDataSource.getHouses();
      return right(houses);
    } on ServerFailure catch (failure) {
      return left(failure);
    } catch (failure) {
      return left(GeneralFailure());
    }
  }
}
