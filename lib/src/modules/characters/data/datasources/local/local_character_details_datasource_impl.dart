import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_character_details_datasource.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/models/characters_details_model.dart';

class LocalCharacterDetailsDatasourceImpl
    implements LocalCharacterDetailsDatasource {
  @override
  Future<CharactersDetailsModel> getCharacterDetails(int id) async {
    final String response =
        await rootBundle.loadString('assets/json/character_details/$id.json');
    final Map<String, dynamic> data = json.decode(response);

    return CharactersDetailsModel.fromMap(data);
  }
}
