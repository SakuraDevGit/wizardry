import 'package:domain/entities/spell_entities/spell_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/repositories/spell_repository.dart';
import 'package:domain/result.dart';

class GetSpellsUseCase {
  final SpellRepository spellRepository;

  GetSpellsUseCase({required this.spellRepository});

  Future<Result<List<SpellEntity>, WizardingFailure>> getSpells(
      {bool sortOrderIsAscending = true}) async {
    final spellsOrFailure = await spellRepository.getSpells();
    return spellsOrFailure.sortByName(isAscending: sortOrderIsAscending);
  }

  Future<Result<List<SpellEntity>, WizardingFailure>> getSpellsWith(
      String name, String type, String incantation,
      {bool sortOrderIsAscending = true}) async {
    final spellsOrFailure =
        await spellRepository.getSpellsWith(name, type, incantation);
    return spellsOrFailure.sortByName(isAscending: sortOrderIsAscending);
  }
}

extension SortingExtension on Result<List<SpellEntity>, WizardingFailure> {
  Result<List<SpellEntity>, WizardingFailure> sortByName(
      {bool isAscending = true}) {
    if (this case Success(value: final spells)) {
      spells.sort((a, b) {
        if (isAscending) {
          return a.name.compareTo(b.name);
        } else {
          return b.name.compareTo(a.name);
        }
      });
      return Success(spells);
    } else {
      return this;
    }
  }
}
