import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_characters_datasource.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/models/characters_model.dart';

class LocalCharactersDatasourceImpl implements LocalCharactersDatasource {


  LocalCharactersDatasourceImpl();

  @override
  Future<List<CharactersModel>> fetchCharacters() async {
    final jsonString =
        await rootBundle.loadString('assets/json/characters.json');

    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    final List<dynamic> jsonList = jsonMap['data']['results'];

    return jsonList
        .map((jsonItem) => CharactersModel.fromJson(jsonItem))
        .toList();
  }
}
