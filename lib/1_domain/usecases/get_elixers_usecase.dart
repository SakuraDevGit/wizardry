import 'package:dartz/dartz.dart';
import 'package:wizarding_world/0_data/repositories/elixirs_repository_impl.dart';
import 'package:wizarding_world/1_domain/entities/elixir_entities/elixir_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';
import 'package:wizarding_world/1_domain/repositories/elixirs_repository.dart';

class GetElixirsUseCase {
  final ElixirRepository elixirsRepository;

  GetElixirsUseCase({required this.elixirsRepository});

  Future<Either<Failure, List<ElixirEntity>>> getElixirs(
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
