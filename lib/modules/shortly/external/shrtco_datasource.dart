import 'package:dio/dio.dart';
import 'package:flutter_shortlink/modules/shortly/domain/errors/errors.dart';
import 'package:flutter_shortlink/modules/shortly/infra/datasource/shortly_datasource.dart';
import 'package:flutter_shortlink/modules/shortly/infra/models/link_model.dart';

class ShrtcoDatasourceImpl implements ShortlyDatasource {
  final Dio dio;
  ShrtcoDatasourceImpl(this.dio);

  @override
  Future<LinkModel> shortLink(String link) async {
    final result = await dio.get('https://api.shrtco.de/v2/shorten?url=$link');

    if (result.statusCode == 201) {
      LinkModel _result = LinkModel.fromMap(result.data['result']);

      return _result;
    } else {
      throw DatasourceError();
    }
  }
}
