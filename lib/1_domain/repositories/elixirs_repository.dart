import 'package:dartz/dartz.dart';
import 'package:wizarding_world/1_domain/entities/elixir_entities/elixir_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';

abstract class ElixirRepository {
  Future<Either<Failure, List<ElixirEntity>>> getElixirs();
}
