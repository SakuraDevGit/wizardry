import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wizarding_world/0_data/datasources/house/house_remote_data_source.dart';
import 'package:wizarding_world/0_data/models/house_model.dart';
import 'package:wizarding_world/0_data/repositories/house_repository_impl.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';

import '../datasources/houses_remote_datasource_test.mocks.dart';
import 'house_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HouseRemoteDataSourceImpl>()])
void main() {
  group('HouseRepositoryImpl', () {
    group('should return house entity', () {
      test('when data source returns a HouseEntity', () async {
        // Arrange
        final houseModel = HouseModel(
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
        final mockRemoteDataSource = MockHouseRemoteDataSourceImpl();
        when(mockRemoteDataSource.getHouses())
            .thenAnswer((_) async => [houseModel]);

        final mockLocalDataSource = MockHouseLocalDataSource();

        final houseRepository = HouseRepositoryImpl(
            remoteDataSource: mockRemoteDataSource,
            localDataSource: mockLocalDataSource);

        // Act
        final result = await houseRepository.getHouses();

        // Assert
        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        result.fold((failure) => fail('should not have a value'),
            (houseResult) {
          expect(houseResult.first, houseModel);
        });
        verify(mockRemoteDataSource.getHouses()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      });
    });

    group('should return left with', () {
      test('a server failure when a server exception occurs', () async {
        // Arrange
        final mockRemoteDataSource = MockHouseRemoteDataSourceImpl();
        when(mockRemoteDataSource.getHouses()).thenThrow(ServerFailure());
        final mockLocalDataSource = MockHouseLocalDataSource();
        final houseRepository = HouseRepositoryImpl(
            remoteDataSource: mockRemoteDataSource,
            localDataSource: mockLocalDataSource);

        // Act
        final result = await houseRepository.getHouses();

        // Assert
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
        }, (houseResult) => fail('should not have a value'));
        verify(mockRemoteDataSource.getHouses()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test('a general failure when other exceptions occur', () async {
        // Arrange
        final mockRemoteDataSource = MockHouseRemoteDataSourceImpl();
        when(mockRemoteDataSource.getHouses()).thenThrow(Exception());
        final mockLocalDataSource = MockHouseLocalDataSource();
        final houseRepository = HouseRepositoryImpl(
            remoteDataSource: mockRemoteDataSource,
            localDataSource: mockLocalDataSource);

        // Act
        final result = await houseRepository.getHouses();

        // Assert
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        result.fold((failure) {
          expect(failure, isA<GeneralFailure>());
        }, (houseResult) => fail('should not have a value'));
        verify(mockRemoteDataSource.getHouses()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      });
    });
  });
}
