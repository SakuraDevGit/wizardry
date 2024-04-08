import 'package:http/http.dart' as http;
import 'package:wizarding_world/0_data/datasources/spell_local_data_source.dart';
import 'package:wizarding_world/0_data/datasources/spell_remote_data_source.dart';
import 'package:wizarding_world/0_data/repositories/spell_repository_impl.dart';
import 'package:wizarding_world/1_domain/usecases/get_spells_usecase.dart';
import 'package:wizarding_world/2_application/pages/spells/cubit/spells_cubit.dart';

class SpellFactory {
  static SpellsCubit createCubit() {
    final client = http.Client();
    final localDataSource = SpellLocalDataSource();
    final remoteDataSource = SpellRemoteDataSourceImpl(
        client: client, localDataSource: localDataSource);
    final spellRepository = SpellRepositoryImpl(
        remoteDataSource: remoteDataSource, localDataSource: localDataSource);
    final getSpellsUseCase = GetSpellsUseCase(spellRepository: spellRepository);
    return SpellsCubit(getSpellsUseCase: getSpellsUseCase);
  }
}
