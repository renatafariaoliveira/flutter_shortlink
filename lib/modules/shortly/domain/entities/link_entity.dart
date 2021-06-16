import 'package:flutter/material.dart';

class LinkEntity {
  final String shortLink;
  final String originalLink;
  final UniqueKey id;
  LinkEntity({required this.id, required this.shortLink, required this.originalLink});
}
