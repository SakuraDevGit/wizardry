import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wizarding_world/0_data/repositories/house_repository_impl.dart';
import 'package:domain/entities/house_entities/house_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/usecases/get_houses_usecase.dart';
import 'get_houses_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HouseRepositoryImpl>()])
void main() {
  group('GetHousesUseCase', () {
    group('should return house entity', () {
      test('when repository returns a HouseEntity', () async {
        // Arrange
        final mockHouseRepo = MockHouseRepositoryImpl();
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
        when(mockHouseRepo.getHouses())
            .thenAnswer((_) async => Future.value(Right([houseEntity])));
        final adviceUseCaseUnderTest =
            GetHousesUseCase(houseRepository: mockHouseRepo);

        // Act
        final result = await adviceUseCaseUnderTest.getHouses();

        // Assert
        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        result.fold((failure) => fail('should not have a value'),
            (houseResult) {
          expect(houseResult.first, houseEntity);
        });
        verify(mockHouseRepo.getHouses()).called(1);
        verifyNoMoreInteractions(mockHouseRepo);
      });
    });

    group('should return left with', () {
      test('a server failure when a server exception occurs', () async {
        // Arrange
        final mockHouseRepo = MockHouseRepositoryImpl();
        final houseUseCaseUnderTest =
            GetHousesUseCase(houseRepository: mockHouseRepo);
        when(mockHouseRepo.getHouses())
            .thenAnswer((_) async => Future.value(Left(ServerFailure())));

        // Act
        final result = await houseUseCaseUnderTest.getHouses();

        // Assert
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
        }, (houseResult) {
          fail('should not have a value');
        });
        verify(mockHouseRepo.getHouses()).called(1);
        verifyNoMoreInteractions(mockHouseRepo);
      });

      test('a GeneralFailure when another Failure occurs', () async {
        // Arrange
        final mockHouseRepo = MockHouseRepositoryImpl();
        final houseUseCaseUnderTest =
            GetHousesUseCase(houseRepository: mockHouseRepo);
        when(mockHouseRepo.getHouses())
            .thenAnswer((_) async => Future.value(Left(GeneralFailure())));

        // Act
        final result = await houseUseCaseUnderTest.getHouses();

        // Assert
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        result.fold((failure) {
          expect(failure, isA<GeneralFailure>());
        }, (houseResult) {
          fail('should not have a value');
        });
        verify(mockHouseRepo.getHouses()).called(1);
        verifyNoMoreInteractions(mockHouseRepo);
      });
    });
  });
}
