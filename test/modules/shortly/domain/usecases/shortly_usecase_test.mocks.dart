// Mocks generated by Mockito 5.0.10 from annotations
// in flutter_shortlink/test/modules/shortly/domain/usecases/shortly_usecase_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:flutter_shortlink/modules/shortly/domain/entities/link_entity.dart'
    as _i6;
import 'package:flutter_shortlink/modules/shortly/domain/errors/errors.dart'
    as _i5;
import 'package:flutter_shortlink/modules/shortly/domain/repositories/shortly_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {
  @override
  String toString() => super.toString();
}

/// A class which mocks [ShortlyRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockShortlyRepository extends _i1.Mock implements _i3.ShortlyRepository {
  MockShortlyRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.FailureShortly, _i6.LinkEntity>> shortLink(
          String? link) =>
      (super.noSuchMethod(Invocation.method(#shortLink, [link]),
              returnValue:
                  Future<_i2.Either<_i5.FailureShortly, _i6.LinkEntity>>.value(
                      _FakeEither<_i5.FailureShortly, _i6.LinkEntity>()))
          as _i4.Future<_i2.Either<_i5.FailureShortly, _i6.LinkEntity>>);
}
