import 'package:marvel_characters/src/core/errors/failures.dart';
import 'package:marvel_characters/src/core/utils/result.dart';
import 'package:marvel_characters/src/modules/characters/domain/entities/character_details_entity.dart';

abstract class CharacterDetailsRepository {
  Future<Result<CharacterDetailsEntity, Failure>> getCharacterDetails(int id);
}
