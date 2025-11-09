import 'dart:async';
import 'package:flutter_marvel_characters/src/core/errors/failures.dart';
import 'package:flutter_marvel_characters/src/core/utils/result.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_characters_datasource.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_entity.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/repositories/character_repository.dart';

class CharactersRepositoryImpl implements CharacterRepository {
  LocalCharactersDatasource remoteDatasource;
  CharactersRepositoryImpl({
    required this.remoteDatasource,
  });
  @override
  Future<Result<List<CharacterEntity>, Failure>> fetchCharacters() async {
    try {
      var result = await remoteDatasource.fetchCharacters();
      return Result.success(result);
    } on TimeoutException catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }
}
