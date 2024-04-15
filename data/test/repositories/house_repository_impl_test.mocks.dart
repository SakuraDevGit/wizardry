// Mocks generated by Mockito 5.4.4 from annotations
// in data/test/repositories/house_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:data/datasources/houses/house_local_data_source.dart' as _i3;
import 'package:data/datasources/houses/house_remote_data_source.dart' as _i4;
import 'package:data/models/house_models/house_model.dart' as _i6;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeClient_0 extends _i1.SmartFake implements _i2.Client {
  _FakeClient_0(
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

/// A class which mocks [HouseRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockHouseRemoteDataSourceImpl extends _i1.Mock
    implements _i4.HouseRemoteDataSourceImpl {
  @override
  _i2.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_0(
          this,
          Invocation.getter(#client),
        ),
        returnValueForMissingStub: _FakeClient_0(
          this,
          Invocation.getter(#client),
        ),
      ) as _i2.Client);

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
  _i5.Future<List<_i6.HouseModel>> getHouses() => (super.noSuchMethod(
        Invocation.method(
          #getHouses,
          [],
        ),
        returnValue: _i5.Future<List<_i6.HouseModel>>.value(<_i6.HouseModel>[]),
        returnValueForMissingStub:
            _i5.Future<List<_i6.HouseModel>>.value(<_i6.HouseModel>[]),
      ) as _i5.Future<List<_i6.HouseModel>>);
}
