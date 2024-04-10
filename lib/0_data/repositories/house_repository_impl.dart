import 'package:dartz/dartz.dart';
import 'package:wizarding_world/0_data/datasources/houses/house_local_data_source.dart';
import 'package:wizarding_world/0_data/datasources/houses/house_remote_data_source.dart';
import 'package:wizarding_world/1_domain/entities/house_entities/house_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';
import 'package:wizarding_world/1_domain/repositories/house_repository.dart';

class HouseRepositoryImpl implements HouseRepository {
  final HouseRemoteDataSource remoteDataSource;
  final HouseLocalDataSource localDataSource;

  HouseRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<WizardingFailure, List<HouseEntity>>> getHouses() async {
    try {
      final localHouses = await localDataSource.getHouses();
      if (localHouses.isNotEmpty) {
        return right(localHouses);
      }

      final houses = await remoteDataSource.getHouses();
      return right(houses);
    } on ServerFailure catch (failure) {
      return left(failure);
    } catch (failure) {
      return left(GeneralFailure());
    }
  }
}
