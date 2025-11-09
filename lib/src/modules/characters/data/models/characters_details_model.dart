import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_details_entity.dart';

class CharactersDetailsModel extends CharacterDetailsEntity {
  CharactersDetailsModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.imageUrl,
      required super.comicsCount,
      required super.seriesCount,
      required super.storiesCount,
      required super.eventsCount,
      required super.biography});

    factory CharactersDetailsModel.fromMap(Map<String, dynamic> map) {
    return CharactersDetailsModel(
      id: map['id'] as int,
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      comicsCount: map['comicsCount'] as int? ?? 0,
      seriesCount: map['seriesCount'] as int? ?? 0,
      storiesCount: map['storiesCount'] as int? ?? 0,
      eventsCount: map['eventsCount'] as int? ?? 0,
      biography: map['biography'] as String? ?? '',
    );
  }
}
