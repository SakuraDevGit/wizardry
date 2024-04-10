import 'package:domain/entities/house_entities/house_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/repositories/house_repository.dart';
import 'package:domain/result.dart';

class GetHousesUseCase {
  final HouseRepository houseRepository;

  GetHousesUseCase({required this.houseRepository});

  Future<Result<List<HouseEntity>, WizardingFailure>> getHouses(
      {bool sortOrderIsAscending = true}) async {
    final housesOrFailure = await houseRepository.getHouses();

    if (housesOrFailure case Success(value: final houses)) {
      houses.sort((a, b) {
        if (sortOrderIsAscending) {
          return a.name.compareTo(b.name);
        } else {
          return b.name.compareTo(a.name);
        }
      });
      return Success(houses);
    } else {
      return housesOrFailure;
    }
  }
}
