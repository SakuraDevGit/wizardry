// Mocks generated by Mockito 5.4.4 from annotations
// in wizarding_world/test/1_domain/usecases/get_houses_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wizarding_world/0_data/datasources/houses/house_local_data_source.dart'
    as _i3;
import 'package:wizarding_world/0_data/datasources/houses/house_remote_data_source.dart'
    as _i2;
import 'package:wizarding_world/0_data/repositories/house_repository_impl.dart'
    as _i5;
import 'package:domain/entities/house_entities/house_entity.dart' as _i8;
import 'package:domain/failures/failures.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeHouseRemoteDataSource_0 extends _i1.SmartFake
    implements _i2.HouseRemoteDataSource {
  _FakeHouseRemoteDataSource_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHouseLocalDataSource_1 extends _i1.SmartFake
    implements _i3.HouseLocalDataSource {
  _FakeHouseLocalDataSource_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_2<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HouseRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockHouseRepositoryImpl extends _i1.Mock
    implements _i5.HouseRepositoryImpl {
  @override
  _i2.HouseRemoteDataSource get remoteDataSource => (super.noSuchMethod(
        Invocation.getter(#remoteDataSource),
        returnValue: _FakeHouseRemoteDataSource_0(
          this,
          Invocation.getter(#remoteDataSource),
        ),
        returnValueForMissingStub: _FakeHouseRemoteDataSource_0(
          this,
          Invocation.getter(#remoteDataSource),
        ),
      ) as _i2.HouseRemoteDataSource);

  @override
  _i3.HouseLocalDataSource get localDataSource => (super.noSuchMethod(
        Invocation.getter(#localDataSource),
        returnValue: _FakeHouseLocalDataSource_1(
          this,
          Invocation.getter(#localDataSource),
        ),
        returnValueForMissingStub: _FakeHouseLocalDataSource_1(
          this,
          Invocation.getter(#localDataSource),
        ),
      ) as _i3.HouseLocalDataSource);

  @override
  _i6.Future<_i4.Either<_i7.WizardingFailure, List<_i8.HouseEntity>>>
      getHouses() => (super.noSuchMethod(
            Invocation.method(
              #getHouses,
              [],
            ),
            returnValue: _i6.Future<
                    _i4
                    .Either<_i7.WizardingFailure, List<_i8.HouseEntity>>>.value(
                _FakeEither_2<_i7.WizardingFailure, List<_i8.HouseEntity>>(
              this,
              Invocation.method(
                #getHouses,
                [],
              ),
            )),
            returnValueForMissingStub: _i6.Future<
                    _i4
                    .Either<_i7.WizardingFailure, List<_i8.HouseEntity>>>.value(
                _FakeEither_2<_i7.WizardingFailure, List<_i8.HouseEntity>>(
              this,
              Invocation.method(
                #getHouses,
                [],
              ),
            )),
          ) as _i6
              .Future<_i4.Either<_i7.WizardingFailure, List<_i8.HouseEntity>>>);
}
