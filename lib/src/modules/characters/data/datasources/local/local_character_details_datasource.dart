import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_details_entity.dart';

abstract class LocalCharacterDetailsDatasource {
  Future<CharacterDetailsEntity> getCharacterDetails(int id);
}