import 'package:flutter_marvel_characters/src/core/errors/failures.dart';
import 'package:flutter_marvel_characters/src/core/utils/result.dart';
import 'package:flutter_marvel_characters/src/core/utils/usecase.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_entity.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/repositories/character_repository.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/usecases/get_characters_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

class TMockCharacterEntity extends Mock implements CharacterEntity {}

class TMockServerFailure extends Mock implements ServerFailure {}

final tCharacter = TMockCharacterEntity();
final tCharacterList = [tCharacter, tCharacter];
final tServerFailure = TMockServerFailure();
final tNoParams = NoParams();

void main() {
  late GetCharactersUsecase usecase;
  late MockCharacterRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(tNoParams);
  });

  setUp(() {
    mockRepository = MockCharacterRepository();
    usecase = GetCharactersUsecase(repository: mockRepository);
  });

  group('GetCharactersUsecase', () {
    test('should get a list of CharacterEntity from the repository', () async {
      // Arrange
      when(() => mockRepository.fetchCharacters())
          .thenAnswer((_) async => Result.success(tCharacterList));

      // Act
      final result = await usecase(tNoParams);

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, equals(tCharacterList));

      verify(() => mockRepository.fetchCharacters()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should get a Failure from the repository', () async {
      // Arrange
      when(() => mockRepository.fetchCharacters())
          .thenAnswer((_) async => Result.failure(tServerFailure));

      // Act
      final result = await usecase(tNoParams);

      // Assert
      expect(result.isFailure, true);
      expect(result.error, equals(tServerFailure));

      verify(() => mockRepository.fetchCharacters()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
