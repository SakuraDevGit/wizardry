// Mocks generated by Mockito 5.4.4 from annotations
// in wizarding_world/test/2_application/pages/houses/cubit/houses_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:domain/entities/house_entities/house_entity.dart' as _i6;
import 'package:domain/failures/failures.dart' as _i7;
import 'package:domain/repositories/house_repository.dart' as _i2;
import 'package:domain/result.dart' as _i5;
import 'package:domain/usecases/get_houses_usecase.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;

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

class _FakeHouseRepository_0 extends _i1.SmartFake
    implements _i2.HouseRepository {
  _FakeHouseRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetHousesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetHousesUseCase extends _i1.Mock implements _i3.GetHousesUseCase {
  @override
  _i2.HouseRepository get houseRepository => (super.noSuchMethod(
        Invocation.getter(#houseRepository),
        returnValue: _FakeHouseRepository_0(
          this,
          Invocation.getter(#houseRepository),
        ),
        returnValueForMissingStub: _FakeHouseRepository_0(
          this,
          Invocation.getter(#houseRepository),
        ),
      ) as _i2.HouseRepository);

  @override
  _i4.Future<_i5.Result<List<_i6.HouseEntity>, _i7.WizardingFailure>> getHouses(
          {bool? sortOrderIsAscending = true}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHouses,
          [],
          {#sortOrderIsAscending: sortOrderIsAscending},
        ),
        returnValue: _i4.Future<
                _i5.Result<List<_i6.HouseEntity>, _i7.WizardingFailure>>.value(
            _i8.dummyValue<
                _i5.Result<List<_i6.HouseEntity>, _i7.WizardingFailure>>(
          this,
          Invocation.method(
            #getHouses,
            [],
            {#sortOrderIsAscending: sortOrderIsAscending},
          ),
        )),
        returnValueForMissingStub: _i4.Future<
                _i5.Result<List<_i6.HouseEntity>, _i7.WizardingFailure>>.value(
            _i8.dummyValue<
                _i5.Result<List<_i6.HouseEntity>, _i7.WizardingFailure>>(
          this,
          Invocation.method(
            #getHouses,
            [],
            {#sortOrderIsAscending: sortOrderIsAscending},
          ),
        )),
      ) as _i4.Future<_i5.Result<List<_i6.HouseEntity>, _i7.WizardingFailure>>);
}
