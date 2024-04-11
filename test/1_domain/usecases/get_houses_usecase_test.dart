import 'package:domain/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../data/lib/repositories/house_repository_impl.dart';
import 'package:domain/entities/house_entities/house_entity.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/usecases/get_houses_usecase.dart';
import 'get_houses_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HouseRepositoryImpl>()])
void main() {
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

  Result<List<HouseEntity>, WizardingFailure> success = Success([houseEntity]);
  provideDummy(success);

  group('GetHousesUseCase', () {
    group('should return house entity', () {
      test('when repository returns a HouseEntity', () async {
        // Arrange
        final mockHouseRepo = MockHouseRepositoryImpl();
        final adviceUseCaseUnderTest =
            GetHousesUseCase(houseRepository: mockHouseRepo);

        // Act
        final result = await adviceUseCaseUnderTest.getHouses();

        // Assert
        switch (result) {
          case Success(value: final houses):
            expect(houses.first, houseEntity);
          case Failure(exception: final _):
            fail('should not have a value');
        }
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
            .thenAnswer((_) async => Future.value(Failure(ServerFailure())));

        // Act
        final result = await houseUseCaseUnderTest.getHouses();

        // Assert
        switch (result) {
          case Success(value: final _):
            fail('should not have a value');
          case Failure(exception: final failure):
            expect(failure, isA<ServerFailure>());
        }
        verify(mockHouseRepo.getHouses()).called(1);
        verifyNoMoreInteractions(mockHouseRepo);
      });

      test('a GeneralFailure when another Failure occurs', () async {
        // Arrange
        final mockHouseRepo = MockHouseRepositoryImpl();
        final houseUseCaseUnderTest =
            GetHousesUseCase(houseRepository: mockHouseRepo);
        when(mockHouseRepo.getHouses())
            .thenAnswer((_) async => Future.value(Failure(GeneralFailure())));

        // Act
        final result = await houseUseCaseUnderTest.getHouses();

        // Assert
        switch (result) {
          case Success(value: final _):
            fail('should not have a value');
          case Failure(exception: final failure):
            expect(failure, isA<GeneralFailure>());
        }
        verify(mockHouseRepo.getHouses()).called(1);
        verifyNoMoreInteractions(mockHouseRepo);
      });
    });
  });
}
