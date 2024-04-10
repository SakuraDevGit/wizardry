import 'package:dartz/dartz.dart';
import 'package:domain/entities/elixir_entities/elixir_entity.dart';
import 'package:domain/failures/failures.dart';

abstract class ElixirRepository {
  Future<Either<WizardingFailure, List<ElixirEntity>>> getElixirs();
}
