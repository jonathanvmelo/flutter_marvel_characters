import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_character_details_datasource.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/models/characters_details_model.dart';

class LocalCharacterDetailsDatasourceImpl
    implements LocalCharacterDetailsDatasource {
  @override
  Future<CharactersDetailsModel> getCharacterDetails(int id) async {
    final String response =
        await rootBundle.loadString('assets/json/characters.json');
    final Map<String, dynamic> data = json.decode(response);
 
    final characterData = _findCharacterById(data, id);

    if (characterData != null) {
      return CharactersDetailsModel.fromMap(characterData);
    } else {
      throw Exception('Character with id $id not found');
    }
  }

  Map<String, dynamic>? _findCharacterById(Map<String, dynamic> data, int id) {
    final results = data['data']['results'] as List;

    for (final character in results) {
      if (character['id'] == id) {
        return character;
      }
    }

    return null;
  }
}
