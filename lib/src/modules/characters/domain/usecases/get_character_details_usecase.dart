import 'package:flutter_marvel_characters/src/core/errors/failures.dart';
import 'package:flutter_marvel_characters/src/core/utils/result.dart';
import 'package:flutter_marvel_characters/src/core/utils/usecase.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_details_entity.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/repositories/character_details_repository.dart';

class GetCharacterDetailsUsecase extends Usecase<CharacterDetailsEntity, int> {
  CharacterDetailsRepository repository;
  GetCharacterDetailsUsecase({required this.repository});

  @override
  Future<Result<CharacterDetailsEntity, Failure>> call(int params) async {
    return await repository.getCharacterDetails(params);
  }
}
