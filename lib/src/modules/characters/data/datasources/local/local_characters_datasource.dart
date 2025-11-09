import 'package:flutter_marvel_characters/src/modules/characters/data/models/characters_model.dart';

abstract class LocalCharactersDatasource {
  Future<List<CharactersModel>> fetchCharacters();
}