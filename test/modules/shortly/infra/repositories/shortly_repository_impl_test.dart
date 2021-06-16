import 'package:flutter/material.dart';
import 'package:flutter_shortlink/modules/shortly/domain/entities/link_entity.dart';
import 'package:flutter_shortlink/modules/shortly/domain/errors/errors.dart';
import 'package:flutter_shortlink/modules/shortly/infra/datasource/shortly_datasource.dart';
import 'package:flutter_shortlink/modules/shortly/infra/models/link_model.dart';
import 'package:flutter_shortlink/modules/shortly/infra/repositories/shortly_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'shortly_repository_impl_test.mocks.dart';

@GenerateMocks([ShortlyDatasource])
main() {
  final datasource = MockShortlyDatasource();
  final repository = ShortlyRepositoryImpl(datasource);

  test('Return a LinkEntity', () async {
    final _result = LinkModel(id: UniqueKey(), shortLink: '', originalLink: '');
    when(datasource.shortLink('https://api.shrtco.de/v2/shorten?url=ABC')).thenAnswer((_) async => _result);

    final result = await repository.shortLink('ABC');
    expect(result | _result, isA<LinkEntity>());
  });

  test('Return an error when datasource fails', () async {
    when(datasource.shortLink('https://api.shrtco.de/v2/shorten?url=ABC')).thenThrow(DatasourceError());

    final result = await repository.shortLink('ABC');
    expect(result.isLeft(), true);
  });

  test('Return an error when shrtco fails', () async {
    when(datasource.shortLink('https://api.shrtco.de/v2/shorten?url=ABC')).thenThrow(InvalidUrlError());

    final result = await repository.shortLink('ABC');
    expect(result.isLeft(), true);
  });
}
