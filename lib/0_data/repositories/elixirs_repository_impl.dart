import 'package:dartz/dartz.dart';
import 'package:wizarding_world/0_data/datasources/elixirs/elixir_local_data_source.dart';
import 'package:wizarding_world/0_data/datasources/elixirs/elixir_remote_data_source.dart';
import 'package:domain/entities/elixir_entities/elixir_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/repositories/elixirs_repository.dart';

class ElixirRepositoryImpl implements ElixirRepository {
  final ElixirRemoteDataSource remoteDataSource;
  final ElixirLocalDataSource localDataSource;

  ElixirRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<WizardingFailure, List<ElixirEntity>>> getElixirs() async {
    try {
      final localElixirs = await localDataSource.getElixirs();
      if (localElixirs.isNotEmpty) {
        return right(localElixirs);
      }

      final elixirs = await remoteDataSource.getElixirs();
      return right(elixirs);
    } on ServerFailure catch (failure) {
      return left(failure);
    } catch (failure) {
      return left(GeneralFailure());
    }
  }
}
