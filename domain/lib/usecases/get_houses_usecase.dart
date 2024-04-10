import 'package:dartz/dartz.dart';
import 'package:domain/entities/house_entities/house_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/repositories/house_repository.dart';

class GetHousesUseCase {
  final HouseRepository houseRepository;

  GetHousesUseCase({required this.houseRepository});

  Future<Either<WizardingFailure, List<HouseEntity>>> getHouses(
      {bool sortOrderIsAscending = true}) async {
    final housesOrFailure = await houseRepository.getHouses();
    housesOrFailure.fold(
        (failure) => left(failure),
        (houses) => {
              houses.sort((a, b) {
                if (sortOrderIsAscending) {
                  return a.name.compareTo(b.name);
                } else {
                  return b.name.compareTo(a.name);
                }
              }),
              right(houses)
            });

    return housesOrFailure;
  }
}
