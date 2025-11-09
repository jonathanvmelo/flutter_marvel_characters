import 'package:flutter_marvel_characters/src/modules/characters/data/models/characters_model.dart';

abstract class CharactersRemoteDatasource {
  Future<List<CharactersModel>> fetchCharacters();
}