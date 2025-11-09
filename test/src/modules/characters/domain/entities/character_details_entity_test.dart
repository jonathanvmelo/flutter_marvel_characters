import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_details_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tCharacterEntityA = CharacterDetailsEntity(
    id: 1,
    name: 'A',
    description: 'desc',
    biography: 'bio',
    imageUrl: 'url',
    comicsCount: 0,
    seriesCount: 0,
    storiesCount: 0,
    eventsCount: 0,
  );

  const tCharacterEntityB = CharacterDetailsEntity(
    id: 1,
    name: 'A',
    description: 'desc',
    biography: 'bio',
    imageUrl: 'url',
    comicsCount: 0,
    seriesCount: 0,
    storiesCount: 0,
    eventsCount: 0,
  );

  const tCharacterEntityC = CharacterDetailsEntity(
    id: 2,
    name: 'C',
    description: 'desc diferente',
    biography: 'bio',
    imageUrl: 'url',
    comicsCount: 0,
    seriesCount: 0,
    storiesCount: 0,
    eventsCount: 0,
  );

  group('CharacterDetailsEntity', () {
    test('should be equal when all properties are the same (A equals B)', () {
      expect(tCharacterEntityA, equals(tCharacterEntityB));
      expect(tCharacterEntityA.hashCode, equals(tCharacterEntityB.hashCode));
    });

    test('should NOT be equal when any property is different (A vs C)', () {
      expect(tCharacterEntityA, isNot(equals(tCharacterEntityC)));
      expect(tCharacterEntityA.hashCode,
          isNot(equals(tCharacterEntityC.hashCode)));
    });
  });
}
