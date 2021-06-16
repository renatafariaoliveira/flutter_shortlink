// Mocks generated by Mockito 5.0.10 from annotations
// in flutter_shortlink/test/modules/shortly/infra/repositories/shortly_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:flutter_shortlink/modules/shortly/infra/datasource/shortly_datasource.dart'
    as _i3;
import 'package:flutter_shortlink/modules/shortly/infra/models/link_model.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeLinkModel extends _i1.Fake implements _i2.LinkModel {}

/// A class which mocks [ShortlyDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockShortlyDatasource extends _i1.Mock implements _i3.ShortlyDatasource {
  MockShortlyDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.LinkModel> shortLink(String? link) =>
      (super.noSuchMethod(Invocation.method(#shortLink, [link]),
              returnValue: Future<_i2.LinkModel>.value(_FakeLinkModel()))
          as _i4.Future<_i2.LinkModel>);
}
