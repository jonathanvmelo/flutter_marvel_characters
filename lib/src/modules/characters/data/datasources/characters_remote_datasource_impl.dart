// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/characters_remote_datasource.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/models/characters_model.dart';
import 'package:dio/dio.dart';

class CharactersRemoteDatasourceImpl implements CharactersRemoteDatasource {
  final Dio dio;

  CharactersRemoteDatasourceImpl({required this.dio});

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

  //Example dio implementation.
  // @override
  // Future<List<CharactersModel>> fetchCharacters() async {
  //   String name = '';
  //   int limit = 10;
  //   int offset = 0;

  //   final response = await dio.get(
  //     '/v1/public/characters',
  //     queryParameters: {
  //       'name': name,
  //       'limit': limit,
  //       'offset': offset,
  //       'modifiedSince': '2021-01-01',
  //       'apikey': 'SUA_CHAVE_PUBLICA',
  //     },
  //   );

  //   final List<Map<String, dynamic>> results = response.data['data']['results'];

  //   return results.map((json) => CharactersModel.fromJson(json)).toList();
  // }
}
