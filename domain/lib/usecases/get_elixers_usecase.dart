import 'package:dartz/dartz.dart';
import 'package:domain/entities/elixir_entities/elixir_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/repositories/elixirs_repository.dart';

class GetElixirsUseCase {
  final ElixirRepository elixirsRepository;

  GetElixirsUseCase({required this.elixirsRepository});

  Future<Either<WizardingFailure, List<ElixirEntity>>> getElixirs(
      {bool sortOrderIsAscending = true}) async {
    final elixirsOrFailure = await elixirsRepository.getElixirs();
    elixirsOrFailure.fold(
        (failure) => left(failure),
        (elixirs) => {
              elixirs.sort((a, b) {
                if (sortOrderIsAscending) {
                  return a.name.compareTo(b.name);
                } else {
                  return b.name.compareTo(a.name);
                }
              }),
              right(elixirs)
            });

    return elixirsOrFailure;
  }
}
