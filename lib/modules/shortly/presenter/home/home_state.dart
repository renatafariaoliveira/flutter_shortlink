import 'package:flutter_shortlink/modules/shortly/domain/entities/link_entity.dart';
import 'package:flutter_shortlink/modules/shortly/domain/errors/errors.dart';

abstract class HomeState {}

class HomeSuccessState implements HomeState {
  final LinkEntity link;
  HomeSuccessState(this.link);
}

class HomeFailureState implements HomeState {
  final FailureShortly error;
  HomeFailureState(this.error);
}

class HomeRetrieveLinksState implements HomeState {
  final List<LinkEntity> links;
  HomeRetrieveLinksState(this.links);
}

class HomeDeleteLinkState implements HomeState {
  final List<LinkEntity> links;
  HomeDeleteLinkState(this.links);
}

class HomeLoadingState implements HomeState {}

class HomeStartState implements HomeState {}
