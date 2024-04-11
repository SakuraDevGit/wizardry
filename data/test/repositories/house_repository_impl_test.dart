import 'package:data/datasources/houses/house_remote_data_source.dart';
import 'package:data/models/house_model.dart';
import 'package:data/repositories/house_repository_impl.dart';
import 'package:domain/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:domain/failures/failures.dart';

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
        switch (result) {
          case Success(value: final houses):
            expect(houses.first, houseModel);
          case Failure(exception: final _):
            fail('should not have a value');
        }
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
        switch (result) {
          case Success(value: final _):
            fail('should not have a value');
          case Failure(exception: final failure):
            expect(failure, isA<ServerFailure>());
        }
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
        switch (result) {
          case Success(value: final _):
            fail('should not have a value');
          case Failure(exception: final failure):
            expect(failure, isA<GeneralFailure>());
        }
        verify(mockRemoteDataSource.getHouses()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      });
    });
  });
}
