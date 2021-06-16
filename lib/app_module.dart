import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_shortlink/modules/shortly/domain/usecases/shortly_usecase.dart';
import 'package:flutter_shortlink/modules/shortly/external/shrtco_datasource.dart';
import 'package:flutter_shortlink/modules/shortly/infra/repositories/shortly_repository_impl.dart';
import 'package:flutter_shortlink/modules/shortly/presenter/home/home_bloc.dart';
import 'package:flutter_shortlink/modules/shortly/presenter/home/home_widget.dart';
import 'package:flutter_shortlink/modules/shortly/presenter/onboarding/onboarding_widget.dart';
import 'package:flutter_shortlink/modules/shortly/presenter/splash/splash_widget.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => ShortLinkUseCaseImpl(i())),
        Bind((i) => ShortlyRepositoryImpl(i())),
        Bind((i) => ShrtcoDatasourceImpl(i())),
        Bind((i) => HomeBloc(i())),
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => SplashPage()),
    ChildRoute('/onboarding', transition: TransitionType.fadeIn, duration: Duration(milliseconds: 500), child: (_, __) => OnboardingPage()),
    ChildRoute('/home', transition: TransitionType.fadeIn, duration: Duration(milliseconds: 500), child: (_, __) => HomePage()),
  ];
}
