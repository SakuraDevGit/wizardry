import 'package:dartz/dartz.dart';
import 'package:wizarding_world/0_data/datasources/spells/spell_local_data_source.dart';
import 'package:wizarding_world/0_data/datasources/spells/spell_remote_data_source.dart';
import 'package:wizarding_world/1_domain/entities/spell_entities/spell_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';
import 'package:wizarding_world/1_domain/repositories/spell_repository.dart';

class SpellRepositoryImpl implements SpellRepository {
  final SpellRemoteDataSource remoteDataSource;
  final SpellLocalDataSource localDataSource;

  SpellRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<SpellEntity>>> getSpells() async {
    try {
      final localSpells = await localDataSource.getSpells();
      if (localSpells.isNotEmpty) {
        return right(localSpells);
      }

      final spells = await remoteDataSource.getSpells();
      return right(spells);
    } on ServerFailure catch (failure) {
      return left(failure);
    } catch (failure) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<SpellEntity>>> getSpellsWith(
      String name, String type, String incantation) async {
    try {
      final spells =
          await remoteDataSource.getSpellsWith(name, type, incantation);
      return right(spells);
    } on ServerFailure catch (failure) {
      return left(failure);
    } catch (failure) {
      return left(GeneralFailure());
    }
  }
}
