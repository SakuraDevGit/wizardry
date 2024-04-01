import 'package:dartz/dartz.dart';
import 'package:wizarding_world/0_data/repositories/elixirs_repository_impl.dart';
import 'package:wizarding_world/1_domain/entities/elixir_entities/elixir_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';
import 'package:wizarding_world/1_domain/repositories/elixirs_repository.dart';

class GetElixirsUseCase {
  final ElixirRepository _elixirsRepository = ElixirRepositoryImpl();

  Future<Either<Failure, List<ElixirEntity>>> getElixirs() {
    return _elixirsRepository.getElixirs();
  }
}
