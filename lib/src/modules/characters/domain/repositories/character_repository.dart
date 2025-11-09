

import 'package:flutter_marvel_characters/src/core/errors/failures.dart';
import 'package:flutter_marvel_characters/src/core/utils/result.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future< Result<List<CharacterEntity>, Failure>> fetchCharacters();
}
