import 'package:data/datasources/spells/spell_local_data_source.dart';
import 'package:data/datasources/spells/spell_remote_data_source.dart';
import 'package:data/repositories/spell_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:domain/usecases/get_spells_usecase.dart';
import 'package:wizarding_world/2_application/pages/spells/cubit/spells_cubit.dart';

class SpellFactory {
  static SpellsCubit createCubit() {
    final client = http.Client();
    final localDataSource = SpellLocalDataSourceImpl();
    final remoteDataSource = SpellRemoteDataSourceImpl(
        client: client, localDataSource: localDataSource);
    final spellRepository = SpellRepositoryImpl(
        remoteDataSource: remoteDataSource, localDataSource: localDataSource);
    final getSpellsUseCase = GetSpellsUseCase(spellRepository: spellRepository);
    return SpellsCubit(getSpellsUseCase: getSpellsUseCase);
  }
}
