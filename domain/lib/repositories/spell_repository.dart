import 'package:domain/entities/spell_entities/spell_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/result.dart';

abstract class SpellRepository {
  Future<Result<List<SpellEntity>, WizardingFailure>> getSpells();
  Future<Result<List<SpellEntity>, WizardingFailure>> getSpellsWith(
      String name, String type, String incantation);
}
