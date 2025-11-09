import 'package:flutter_marvel_characters/src/core/errors/failures.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_character_details_datasource.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/models/characters_details_model.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/repositories/character_details_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class TMockCharacterDetailsModel extends Mock
    implements CharactersDetailsModel {}

class TMockServerFailure extends Mock implements ServerFailure {}

class MockLocalCharacterDetailsDatasource extends Mock
    implements LocalCharacterDetailsDatasource {}

const tCharacterId = 1009189;
final tCharacterModel = TMockCharacterDetailsModel();
final tServerFailure = TMockServerFailure();
final tException = Exception('Character not found');

void main() {
  late CharacterDetailsRepositoryImpl repository;
  late MockLocalCharacterDetailsDatasource mockDatasource;

  setUpAll(() {
    registerFallbackValue(tCharacterId);
  });

  setUp(() {
    mockDatasource = MockLocalCharacterDetailsDatasource();
    repository =
        CharacterDetailsRepositoryImpl(localDatasource: mockDatasource);
  });

  group('getCharacterDetails (Repository)', () {
    test(
        'should return a CharacterDetailsEntity when the Datasource is successful',
        () async {
      // Arrange
      when(() => mockDatasource.getCharacterDetails(any()))
          .thenAnswer((_) async => tCharacterModel);

      // Act
      final result = await repository.getCharacterDetails(tCharacterId);

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, equals(tCharacterModel));

      verify(() => mockDatasource.getCharacterDetails(tCharacterId)).called(1);
    });

    test('should return ServerFailure when the Datasource throws an Exception',
        () async {
      // Arrange
      when(() => mockDatasource.getCharacterDetails(any()))
          .thenThrow(tException);

      // Act
      final result = await repository.getCharacterDetails(tCharacterId);

      // Assert
      expect(result.isFailure, true);

      expect(result.error, isA<ServerFailure>());

      verify(() => mockDatasource.getCharacterDetails(tCharacterId)).called(1);
    });
  });
}
