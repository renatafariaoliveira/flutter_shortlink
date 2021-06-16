import 'package:flutter_shortlink/modules/shortly/infra/models/link_model.dart';

abstract class ShortlyDatasource {
  Future<LinkModel> shortLink(String link);
}
