import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_character_details_datasource_impl.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/models/characters_details_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

const tCharacterId = 1009189;

const tMockJson = '''
{
  "data": {
    "results": [
      {
        "id": 1009189,
        "name": "Black Panther",
        "description": "King T'Challa of Wakanda...",
        "biography": "...",
        "thumbnail": {
          "path": "http://i.annihil.us/u/prod/marvel/i/mg/3/20/526952774be7a",
          "extension": "jpg"
        },
        "comics": {"available": 150},
        "series": {"available": 50},
        "stories": {"available": 100},
        "events": {"available": 10}
      },
      {
        "id": 1009368,
        "name": "Iron Man",
        "description": "Tony Stark...",
        "biography": "...",
        "thumbnail": {
          "path": "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/52718ec21d4d1",
          "extension": "jpg"
        },
        "comics": {"available": 500},
        "series": {"available": 200},
        "stories": {"available": 300},
        "events": {"available": 50}
      }
    ]
  }
}
''';

final tExpectedModel = CharactersDetailsModel.fromMap(
    json.decode(tMockJson)['data']['results'][0] as Map<String, dynamic>);
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LocalCharacterDetailsDatasourceImpl datasource;
  late MockAssetBundle mockAssetBundle;

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    datasource =
        LocalCharacterDetailsDatasourceImpl(assetBundle: mockAssetBundle);

    when(() => mockAssetBundle.loadString(any()))
        .thenAnswer((_) async => tMockJson);
  });

  group('LocalCharacterDetailsDatasourceImpl', () {
    test('should return CharactersDetailsModel when character is found',
        () async {
      // Act
      final result = await datasource.getCharacterDetails(tCharacterId);

      // Assert
      expect(result, isA<CharactersDetailsModel>());

      expect(result.id, tCharacterId);
      expect(result.name, 'Black Panther');
      expect(result.comicsCount, 150);
    });

    test('should throw Exception when character is not found', () async {
      // Arrange
      const tNonExistentId = 999999;

      expect(
        () => datasource.getCharacterDetails(tNonExistentId),
        throwsA(isA<Exception>()),
      );
    });
  });
}
