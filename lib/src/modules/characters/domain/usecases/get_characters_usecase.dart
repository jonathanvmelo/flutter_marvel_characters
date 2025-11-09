

import 'package:flutter_marvel_characters/src/core/errors/failures.dart';
import 'package:flutter_marvel_characters/src/core/utils/result.dart';
import 'package:flutter_marvel_characters/src/core/utils/usecase.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_entity.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/repositories/character_repository.dart';

class GetCharactersUsecase extends Usecase<List<CharacterEntity>, NoParams> {
  CharacterRepository repository;
  GetCharactersUsecase({required this.repository});
  @override
  Future<Result<List<CharacterEntity>, Failure>> call(NoParams params) async {
    return await repository.fetchCharacters();
  }
}
