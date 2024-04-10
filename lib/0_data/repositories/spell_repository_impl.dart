import 'package:domain/result.dart';
import 'package:wizarding_world/0_data/datasources/spells/spell_local_data_source.dart';
import 'package:wizarding_world/0_data/datasources/spells/spell_remote_data_source.dart';
import 'package:domain/entities/spell_entities/spell_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/repositories/spell_repository.dart';

class SpellRepositoryImpl implements SpellRepository {
  final SpellRemoteDataSource remoteDataSource;
  final SpellLocalDataSource localDataSource;

  SpellRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<List<SpellEntity>, WizardingFailure>> getSpells() async {
    try {
      final localSpells = await localDataSource.getSpells();
      if (localSpells.isNotEmpty) {
        return Success(localSpells);
      }

      final spells = await remoteDataSource.getSpells();
      return Success(spells);
    } on ServerFailure catch (failure) {
      return Failure(failure);
    } catch (failure) {
      return Failure(GeneralFailure());
    }
  }

  @override
  Future<Result<List<SpellEntity>, WizardingFailure>> getSpellsWith(
      String name, String type, String incantation) async {
    try {
      final spells =
          await remoteDataSource.getSpellsWith(name, type, incantation);
      return Success(spells);
    } on ServerFailure catch (failure) {
      return Failure(failure);
    } catch (failure) {
      return Failure(GeneralFailure());
    }
  }
}
