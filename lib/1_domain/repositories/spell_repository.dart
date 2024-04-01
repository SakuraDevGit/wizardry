import 'package:dartz/dartz.dart';
import 'package:wizarding_world/1_domain/entities/spell_entities/spell_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';

abstract class SpellRepository {
  Future<Either<Failure, List<SpellEntity>>> getSpells();
  Future<Either<Failure, List<SpellEntity>>> getSpellsWith(
      String name, String type, String incantation);
}
