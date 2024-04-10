import 'package:domain/entities/elixir_entities/elixir_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/repositories/elixirs_repository.dart';
import 'package:domain/result.dart';

class GetElixirsUseCase {
  final ElixirRepository elixirsRepository;

  GetElixirsUseCase({required this.elixirsRepository});

  Future<Result<List<ElixirEntity>, WizardingFailure>> getElixirs(
      {bool sortOrderIsAscending = true}) async {
    final elixirsOrFailure = await elixirsRepository.getElixirs();

    if (elixirsOrFailure case Success(value: final elixirs)) {
      elixirs.sort((a, b) {
        if (sortOrderIsAscending) {
          return a.name.compareTo(b.name);
        } else {
          return b.name.compareTo(a.name);
        }
      });
      return Success(elixirs);
    } else {
      return elixirsOrFailure;
    }
  }
}
