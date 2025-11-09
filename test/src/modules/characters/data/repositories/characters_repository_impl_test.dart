import 'dart:async';
import 'package:flutter_marvel_characters/src/core/errors/failures.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_characters_datasource.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/models/characters_model.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/repositories/characters_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class TMockCharacterModel extends Mock implements CharactersModel {}

class TMockServerFailure extends Mock implements ServerFailure {}

class TMockTimeoutException extends Mock implements TimeoutException {}

class MockLocalCharactersDatasource extends Mock
    implements LocalCharactersDatasource {}

final tCharacterModel = TMockCharacterModel();
final tCharacterList = [tCharacterModel, tCharacterModel];
final tServerFailure = TMockServerFailure();
final tTimeoutException = TMockTimeoutException();

void main() {
  late CharactersRepositoryImpl repository;
  late MockLocalCharactersDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockLocalCharactersDatasource();
    repository = CharactersRepositoryImpl(remoteDatasource: mockDatasource);
  });

  group('fetchCharacters (Repository)', () {
    test(
        'should return a list of CharacterEntity when the Datasource is successful',
        () async {
      when(() => mockDatasource.fetchCharacters())
          .thenAnswer((_) async => tCharacterList);

      // Act
      final result = await repository.fetchCharacters();

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, equals(tCharacterList));
      verify(() => mockDatasource.fetchCharacters()).called(1);
    });

    test(
        'should return ServerFailure when the Datasource throws TimeoutException',
        () async {
      // Arrange
      when(() => mockDatasource.fetchCharacters())
          .thenThrow(TimeoutException('Request timed out'));

      // Act
      final result = await repository.fetchCharacters();

      // Assert
      expect(result.isFailure, true);
      expect(result.error, isA<ServerFailure>());
      verify(() => mockDatasource.fetchCharacters()).called(1);
    });

    test(
        'should return ServerFailure when the Datasource throws a generic Exception',
        () async {
      // Arrange
      when(() => mockDatasource.fetchCharacters())
          .thenThrow(Exception('Generic error occurred'));

      // Act
      final result = await repository.fetchCharacters();

      // Assert
      expect(result.isFailure, true);
      expect(result.error, isA<ServerFailure>());
      verify(() => mockDatasource.fetchCharacters()).called(1);
    });
  });
}
