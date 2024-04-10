import 'package:dartz/dartz.dart';
import 'package:domain/entities/spell_entities/spell_entity.dart';
import 'package:domain/failures/failures.dart';

abstract class SpellRepository {
  Future<Either<WizardingFailure, List<SpellEntity>>> getSpells();
  Future<Either<WizardingFailure, List<SpellEntity>>> getSpellsWith(
      String name, String type, String incantation);
}
