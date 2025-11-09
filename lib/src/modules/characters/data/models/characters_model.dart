import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_entity.dart';

class CharactersModel extends CharacterEntity {
  const CharactersModel({
    required int id,
    required String name,
    required String description,
    required String imageUrl,
    required int comicsCount,
    required int seriesCount,
    required int storiesCount,
    required int eventsCount,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          comicsCount: comicsCount,
          seriesCount: seriesCount,
          storiesCount: storiesCount,
          eventsCount: eventsCount,
        );

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'];
    return CharactersModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      imageUrl: '${thumbnail['path']}.${thumbnail['extension']}',
      comicsCount: json['comics']['available'],
      seriesCount: json['series']['available'],
      storiesCount: json['stories']['available'],
      eventsCount: json['events']['available'],
    );
  }
}
