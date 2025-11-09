import 'package:flutter_marvel_characters/src/core/errors/failures.dart';
import 'package:flutter_marvel_characters/src/core/utils/result.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_character_details_datasource.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_details_entity.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/repositories/character_details_repository.dart';

class CharacterDetailsRepositoryImpl implements CharacterDetailsRepository {
  final LocalCharacterDetailsDatasource localDatasource;

  CharacterDetailsRepositoryImpl({required this.localDatasource});
  @override
  Future<Result<CharacterDetailsEntity, Failure>> getCharacterDetails(
      int id) async {
    try {
      var result = await localDatasource.getCharacterDetails(id);
      return Result.success(result);
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }
}
