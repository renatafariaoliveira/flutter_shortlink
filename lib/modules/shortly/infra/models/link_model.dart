import 'package:flutter/material.dart';
import 'package:flutter_shortlink/modules/shortly/domain/entities/link_entity.dart';

class LinkModel extends LinkEntity {
  final String shortLink;
  final String originalLink;
  final UniqueKey id;
  LinkModel({required this.id, required this.shortLink, required this.originalLink})
      : super(id: id, shortLink: shortLink, originalLink: originalLink);

  static LinkModel fromMap(Map<String, dynamic> map) {
    return LinkModel(
      id: UniqueKey(),
      shortLink: map['full_short_link'],
      originalLink: map['original_link'],
    );
  }
}
