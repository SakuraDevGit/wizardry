import 'package:dartz/dartz.dart';
import 'package:domain/entities/spell_entities/spell_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/repositories/spell_repository.dart';

class GetSpellsUseCase {
  final SpellRepository spellRepository;

  GetSpellsUseCase({required this.spellRepository});

  Future<Either<WizardingFailure, List<SpellEntity>>> getSpells(
      {bool sortOrderIsAscending = true}) async {
    final spellsOrFailure = await spellRepository.getSpells();
    spellsOrFailure.sortByName(isAscending: sortOrderIsAscending);
    return spellsOrFailure;
  }

  Future<Either<WizardingFailure, List<SpellEntity>>> getSpellsWith(
      String name, String type, String incantation,
      {bool sortOrderIsAscending = true}) async {
    final spellsOrFailure =
        await spellRepository.getSpellsWith(name, type, incantation);
    spellsOrFailure.sortByName(isAscending: sortOrderIsAscending);
    return spellsOrFailure;
  }
}

extension SortingExtension on Either<WizardingFailure, List<SpellEntity>> {
  void sortByName({bool isAscending = true}) {
    fold(
        (failure) => left(failure),
        (spells) => {
              spells.sort((a, b) {
                if (isAscending) {
                  return a.name.compareTo(b.name);
                } else {
                  return b.name.compareTo(a.name);
                }
              }),
              right(spells)
            });
  }
}
