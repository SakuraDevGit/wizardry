import 'package:dartz/dartz.dart';
import 'package:wizarding_world/0_data/datasources/spell_remote_data_source.dart';
import 'package:wizarding_world/1_domain/entities/spell_entities/spell_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';
import 'package:wizarding_world/1_domain/repositories/spell_repository.dart';

class SpellRepositoryImpl implements SpellRepository {
  final SpellRemoteDataSource remoteDataSource = SpellRemoteDataSourceImpl();

  // HouseRepositoryImpl({
  //   required this.remoteDataSource,
  //   required this.localDataSource,
  // });

  @override
  Future<Either<Failure, List<SpellEntity>>> getSpells() async {
    try {
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
