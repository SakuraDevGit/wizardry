import 'package:data/datasources/elixirs/elixir_local_data_source.dart';
import 'package:data/datasources/elixirs/elixir_remote_data_source.dart';
import 'package:data/repositories/elixirs_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:domain/usecases/get_elixers_usecase.dart';
import 'package:wizarding_world/pages/elixirs/cubit/elixirs_cubit.dart';

class ElixirFactory {
  static ElixirsCubit createCubit() {
    final client = http.Client();
    final localDataSource = ElixirLocalDataSourceImpl();
    final remoteDataSource = ElixirRemoteDataSourceImpl(
        client: client, localDataSource: localDataSource);
    final houseRepository = ElixirRepositoryImpl(
        remoteDataSource: remoteDataSource, localDataSource: localDataSource);
    final getHousesUseCase =
        GetElixirsUseCase(elixirsRepository: houseRepository);
    return ElixirsCubit(getElixirsUseCase: getHousesUseCase);
  }
}
