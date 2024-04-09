import 'package:wizarding_world/0_data/datasources/houses/house_local_data_source.dart';
import 'package:wizarding_world/0_data/datasources/houses/house_remote_data_source.dart';
import 'package:wizarding_world/0_data/repositories/house_repository_impl.dart';
import 'package:wizarding_world/1_domain/usecases/get_houses_usecase.dart';
import 'package:wizarding_world/2_application/pages/houses/cubit/houses_cubit.dart';
import 'package:http/http.dart' as http;

class HouseFactory {
  static HousesCubit createCubit() {
    final client = http.Client();
    final localDataSource = HouseLocalDataSource();
    final remoteDataSource = HouseRemoteDataSourceImpl(
        client: client, localDataSource: localDataSource);
    final houseRepository = HouseRepositoryImpl(
        remoteDataSource: remoteDataSource, localDataSource: localDataSource);
    final getHousesUseCase = GetHousesUseCase(houseRepository: houseRepository);
    return HousesCubit(getHousesUseCase: getHousesUseCase);
  }
}
