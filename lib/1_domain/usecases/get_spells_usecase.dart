import 'package:dartz/dartz.dart';
import 'package:wizarding_world/0_data/repositories/spell_repository_impl.dart';
import 'package:wizarding_world/1_domain/entities/spell_entities/spell_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';
import 'package:wizarding_world/1_domain/repositories/spell_repository.dart';

class GetSpellsUseCase {
  final SpellRepository _spellRepository = SpellRepositoryImpl();

  Future<Either<Failure, List<SpellEntity>>> getSpells() {
    return _spellRepository.getSpells();
  }

  Future<Either<Failure, List<SpellEntity>>> getSpellsWith(
      String name, String type, String incantation) {
    return _spellRepository.getSpellsWith(name, type, incantation);
  }
}
