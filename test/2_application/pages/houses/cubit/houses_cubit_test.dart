import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wizarding_world/1_domain/entities/house_entities/house_entity.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';
import 'package:wizarding_world/1_domain/usecases/get_houses_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:wizarding_world/2_application/pages/houses/cubit/houses_cubit.dart';
import 'package:wizarding_world/2_application/pages/houses/cubit/houses_state.dart';
import 'houses_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetHousesUseCase>()])
void main() {
  group('HousesCubit', () {
    group('when getHouses is called and a house entity is returned', () {
      // Arrange
      final houseEntity = HouseEntity(
        id: '1',
        name: 'Gryffindor',
        houseColours: 'Scarlet and Gold',
        founder: 'Godric Gryffindor',
        animal: 'Lion',
        element: 'Fire',
        ghost: 'Nearly Headless Nick',
        commonRoom: 'Gryffindor Tower',
        heads: [],
        traits: [],
      );
      final mockHouseUseCase = MockGetHousesUseCase();
      when(mockHouseUseCase.getHouses())
          .thenAnswer((_) async => Right([houseEntity]));

      blocTest<HousesCubit, HousesCubitState>(
        'emits nothing when no event is added.',
        build: () => HousesCubit(getHousesUseCase: mockHouseUseCase),
        expect: () => const <State>[],
      );

      blocTest(
          'loading state and HousesStateLoaded when adviceRequested is called',
          build: () => HousesCubit(getHousesUseCase: mockHouseUseCase),
          act: (HousesCubit cubit) => cubit.housesRequested(),
          expect: () => <HousesCubitState>[
                HousesStateLoading(),
                HousesStateLoaded(houses: [houseEntity]),
              ]);
    });

    group('when getHouses is called and an error is returned', () {
      // Arrange
      final mockHouseUseCase = MockGetHousesUseCase();
      when(mockHouseUseCase.getHouses())
          .thenAnswer((_) async => Left(ServerFailure()));

      blocTest(
          'loading state and HousesStateError when adviceRequested is called',
          build: () => HousesCubit(getHousesUseCase: mockHouseUseCase),
          act: (HousesCubit cubit) => cubit.housesRequested(),
          expect: () => <HousesCubitState>[
                HousesStateLoading(),
                const HousesStateError(
                    message: 'Oops, API Error. Please try again.'),
              ]);
    });
  });
}
