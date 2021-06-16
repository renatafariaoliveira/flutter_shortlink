import 'package:dartz/dartz.dart';
import 'package:flutter_shortlink/modules/shortly/domain/entities/link_entity.dart';
import 'package:flutter_shortlink/modules/shortly/domain/errors/errors.dart';

abstract class ShortlyRepository {
  Future<Either<FailureShortly, LinkEntity>> shortLink(String link);
}
