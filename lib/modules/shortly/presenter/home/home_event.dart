import 'package:flutter/material.dart';

abstract class HomeEvent {}

class ShortEvent extends HomeEvent {
  final String link;
  ShortEvent(this.link);
}

class RetrieveLinksEvent extends HomeEvent {}

class StartEvent extends HomeEvent {}

class DeleteLinkEvent extends HomeEvent {
  final UniqueKey id;
  DeleteLinkEvent(this.id);
}
