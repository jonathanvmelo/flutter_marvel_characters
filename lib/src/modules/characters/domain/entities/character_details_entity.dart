import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_entity.dart';

class CharacterDetailsEntity extends CharacterEntity {
  final String biography; 
  final String fullDescription; 

  const CharacterDetailsEntity({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.comicsCount,
    required super.seriesCount,
    required super.storiesCount,
    required super.eventsCount,
    required this.biography,
    this.fullDescription = '',
  });

  factory CharacterDetailsEntity.fromCharacter({
    required CharacterEntity character,
    required String biography,
    String fullDescription = '',
  }) {
    return CharacterDetailsEntity(
      id: character.id,
      name: character.name,
      description: character.description,
      imageUrl: character.imageUrl,
      comicsCount: character.comicsCount,
      seriesCount: character.seriesCount,
      storiesCount: character.storiesCount,
      eventsCount: character.eventsCount,
      biography: biography,
      fullDescription: fullDescription,
    );
  }
}