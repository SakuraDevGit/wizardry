import 'package:domain/entities/elixir_entities/elixir_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/result.dart';

abstract class ElixirRepository {
  Future<Result<List<ElixirEntity>, WizardingFailure>> getElixirs();
}
