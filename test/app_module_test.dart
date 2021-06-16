import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_shortlink/app_module.dart';
import 'package:flutter_shortlink/modules/shortly/domain/entities/link_entity.dart';
import 'package:flutter_shortlink/modules/shortly/domain/usecases/shortly_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'app_module_test.mocks.dart';
import 'modules/shortly/utils/api_result_mock.dart';

@GenerateMocks([Dio])
main() {
  final dio = MockDio();

  initModule(AppModule(), replaceBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test('Get usecase without errors', () {
    final usecase = Modular.get<ShortLinkUseCase>();
    expect(usecase, isA<ShortLinkUseCaseImpl>());
  });

  test('Get LinkEntity', () async {
    final _result = LinkEntity(id: UniqueKey(), shortLink: '', originalLink: '');
    when(dio.get('https://api.shrtco.de/v2/shorten?url=ABC'))
        .thenAnswer((_) async => Response(data: jsonDecode(successResult), statusCode: 201, requestOptions: RequestOptions(path: '')));

    final usecase = Modular.get<ShortLinkUseCase>();
    final result = await usecase('ABC');

    expect(result | _result, isA<LinkEntity>());
  });
}
