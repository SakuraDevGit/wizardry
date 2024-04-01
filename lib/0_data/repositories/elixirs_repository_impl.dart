import 'package:dartz/dartz.dart';
import 'package:wizarding_world/0_data/datasources/elixir_remote_data_source.dart';
import 'package:wizarding_world/1_domain/entities/elixir_entities/elixir_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';
import 'package:wizarding_world/1_domain/repositories/elixirs_repository.dart';

class ElixirRepositoryImpl implements ElixirRepository {
  final ElixirRemoteDataSource _elixirDataSource = ElixirRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<ElixirEntity>>> getElixirs() async {
    try {
      final elixirs = await _elixirDataSource.getElixirs();
      return right(elixirs);
    } on ServerFailure catch (failure) {
      return left(failure);
    } catch (failure) {
      return left(GeneralFailure());
    }
  }
}
