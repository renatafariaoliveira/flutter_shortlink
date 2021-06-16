import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_shortlink/modules/shortly/domain/errors/errors.dart';
import 'package:flutter_shortlink/modules/shortly/external/shrtco_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../utils/api_result_mock.dart';
import 'shrtco_datasource_test.mocks.dart';

@GenerateMocks([Dio])
main() {
  final dio = MockDio();
  final datasource = ShrtcoDatasourceImpl(dio);

  test('Return a LinkModel', () async {
    when(dio.get('https://api.shrtco.de/v2/shorten?url=ABC'))
        .thenAnswer((_) async => Response(data: jsonDecode(successResult), statusCode: 201, requestOptions: RequestOptions(path: '')));

    final result = datasource.shortLink('ABC');
    expect(result, completes);
  });

  test('Return an error when status code 404', () async {
    when(dio.get('https://api.shrtco.de/v2/shorten?url=ABC'))
        .thenAnswer((_) async => Response(data: jsonDecode(errorResult), statusCode: 404, requestOptions: RequestOptions(path: '')));

    final result = datasource.shortLink('ABC');
    expect(result, throwsA(isA<DatasourceError>()));
  });

  test('Return an error when platform error', () async {
    when(dio.get('https://api.shrtco.de/v2/shorten?url=ABC')).thenThrow(Exception());

    final result = datasource.shortLink('ABC');
    expect(result, throwsA(isA<Exception>()));
  });
}
