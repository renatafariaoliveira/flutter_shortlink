import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shortlink/modules/shortly/domain/errors/errors.dart';
import 'package:flutter_shortlink/modules/shortly/domain/entities/link_entity.dart';
import 'package:flutter_shortlink/modules/shortly/domain/repositories/shortly_repository.dart';
import 'package:flutter_shortlink/modules/shortly/infra/datasource/shortly_datasource.dart';

class ShortlyRepositoryImpl implements ShortlyRepository {
  final ShortlyDatasource datasource;

  ShortlyRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureShortly, LinkEntity>> shortLink(String link) async {
    try {
      final result = await datasource.shortLink(link);
      return Right(result);
    } on DioError catch (e) {
      switch (e.response!.data['error_code']) {
        case 1:
          return Left(NoUrlError());
        case 2:
          return Left(InvalidUrlError());
        case 3:
          return Left(RateLimitError());
        case 4:
          return Left(BlockedIpError());
        case 5:
          return Left(ShrtcodeUseError());
        case 6:
          return Left(UnknowError());
        case 7:
          return Left(NoCodeError());
        case 8:
          return Left(InvalidCodeError());
        case 9:
          return Left(MissingRequiredParametersError());
        case 10:
          return Left(DisallowedLinkError());
        default:
          return Left(DatasourceError());
      }
    } catch (error) {
      return Left(DatasourceError());
    }
  }
}
