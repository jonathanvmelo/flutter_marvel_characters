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
    int _extractCount(Map<String, dynamic>? resourceMap) {
      if (resourceMap == null || !resourceMap.containsKey('available')) {
        return 0;
      }
      return resourceMap['available'] as int? ?? 0;
    }

    return CharactersDetailsModel(
      id: map['id'] as int,
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      imageUrl: '${map['thumbnail']['path']}.${map['thumbnail']['extension']}',
      comicsCount: _extractCount(map['comics'] as Map<String, dynamic>?),
      seriesCount: _extractCount(map['series'] as Map<String, dynamic>?),
      storiesCount: _extractCount(map['stories'] as Map<String, dynamic>?),
      eventsCount: _extractCount(map['events'] as Map<String, dynamic>?),
      biography: map['biography'] as String? ?? '',
    );
  }
}
