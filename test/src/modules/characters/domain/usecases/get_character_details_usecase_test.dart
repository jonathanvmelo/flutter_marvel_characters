import 'package:flutter_marvel_characters/src/core/errors/failures.dart';
import 'package:flutter_marvel_characters/src/core/utils/result.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_details_entity.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/repositories/character_details_repository.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/usecases/get_character_details_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterDetailsRepository extends Mock
    implements CharacterDetailsRepository {}

class TMockCharacterDetailsEntity extends Mock
    implements CharacterDetailsEntity {}

class TMockServerFailure extends Mock implements ServerFailure {}

const tCharacterId = 1009189;
final tCharacter = TMockCharacterDetailsEntity();
final tServerFailure = TMockServerFailure();

void main() {
  late GetCharacterDetailsUsecase usecase;
  late MockCharacterDetailsRepository mockRepository;

  setUp(() {
    mockRepository = MockCharacterDetailsRepository();
    usecase = GetCharacterDetailsUsecase(repository: mockRepository);

    registerFallbackValue(tCharacterId);
  });

  group('GetCharacterDetailsUsecase', () {
    test('should get a single CharacterDetailsEntity from the repository',
        () async {
      // Arrange
      when(() => mockRepository.getCharacterDetails(any()))
          .thenAnswer((_) async => Result.success(tCharacter));

      // Act
      final result = await usecase(tCharacterId);

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, equals(tCharacter));

      verify(() => mockRepository.getCharacterDetails(tCharacterId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return a Failure from the repository', () async {
      // Arrange
      when(() => mockRepository.getCharacterDetails(any()))
          .thenAnswer((_) async => Result.failure(tServerFailure));

      // Act
      final result = await usecase(tCharacterId);

      // Assert
      expect(result.isFailure, true);
      expect(result.error, equals(tServerFailure));

      verify(() => mockRepository.getCharacterDetails(tCharacterId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
