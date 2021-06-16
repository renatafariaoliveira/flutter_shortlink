import 'package:dartz/dartz.dart';
import 'package:flutter_shortlink/modules/shortly/domain/entities/link_entity.dart';
import 'package:flutter_shortlink/modules/shortly/domain/errors/errors.dart';
import 'package:flutter_shortlink/modules/shortly/domain/repositories/shortly_repository.dart';

abstract class ShortLinkUseCase {
  Future<Either<FailureShortly, LinkEntity>> call(String link);
}

class ShortLinkUseCaseImpl implements ShortLinkUseCase {
  final ShortlyRepository repository;

  ShortLinkUseCaseImpl(this.repository);

  @override
  Future<Either<FailureShortly, LinkEntity>> call(String link) async {
    return repository.shortLink(link);
  }
}
