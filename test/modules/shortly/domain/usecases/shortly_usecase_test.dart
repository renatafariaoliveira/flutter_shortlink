import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shortlink/modules/shortly/domain/entities/link_entity.dart';
import 'package:flutter_shortlink/modules/shortly/domain/errors/errors.dart';
import 'package:flutter_shortlink/modules/shortly/domain/repositories/shortly_repository.dart';
import 'package:flutter_shortlink/modules/shortly/domain/usecases/shortly_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'shortly_usecase_test.mocks.dart';

@GenerateMocks([ShortlyRepository])
main() {
  final repository = MockShortlyRepository();
  final usecase = ShortLinkUseCaseImpl(repository);

  test('Return a LinkEntity', () async {
    final _result = LinkEntity(id: UniqueKey(), shortLink: '', originalLink: '');
    when(repository.shortLink('TEST')).thenAnswer((_) async => Right(_result));

    final result = await usecase('TEST');
    expect(result.isRight(), true);
    expect(result | _result, isA<LinkEntity>());
  });

  test('Return an error', () async {
    when(repository.shortLink('XYZ')).thenAnswer((_) async => Left(DatasourceError()));

    var result = await usecase('XYZ');
    expect(result.isLeft(), true);
  });
}
