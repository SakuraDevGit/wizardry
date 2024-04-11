import 'package:domain/result.dart';
import '../datasources/houses/house_local_data_source.dart';
import '../datasources/houses/house_remote_data_source.dart';
import 'package:domain/entities/house_entities/house_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/repositories/house_repository.dart';

class HouseRepositoryImpl implements HouseRepository {
  final HouseRemoteDataSource remoteDataSource;
  final HouseLocalDataSource localDataSource;

  HouseRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Result<List<HouseEntity>, WizardingFailure>> getHouses() async {
    try {
      final localHouses = await localDataSource.getHouses();
      if (localHouses.isNotEmpty) {
        return Success(localHouses);
      }

      final houses = await remoteDataSource.getHouses();
      return Success(houses);
    } on ServerFailure catch (failure) {
      return Failure(failure);
    } catch (failure) {
      return Failure(GeneralFailure());
    }
  }
}
