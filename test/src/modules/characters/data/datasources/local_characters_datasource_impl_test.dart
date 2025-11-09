import 'package:flutter/services.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_characters_datasource_impl.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/models/characters_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

const tMockJsonList = '''
{
  "data": {
    "results": [
      {
        "id": 1009189,
        "name": "Black Panther",
        "description": "King T'Challa of Wakanda.",
        "thumbnail": {
          "path": "path/panther",
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
        "description": "Tony Stark.",
        "thumbnail": {
          "path": "path/ironman",
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalCharactersDatasourceImpl datasource;
  late MockAssetBundle mockAssetBundle;

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    datasource = LocalCharactersDatasourceImpl(assetBundle: mockAssetBundle);

    when(() => mockAssetBundle.loadString(any()))
        .thenAnswer((_) async => tMockJsonList);
  });

  group('LocalCharactersDatasourceImpl', () {
    test(
        'should return a List<CharactersModel> when assets/json/characters.json is loaded successfully',
        () async {
      // Act
      final result = await datasource.fetchCharacters();

      // Assert
      expect(result, isA<List<CharactersModel>>());
      expect(result.length, 2);

      expect(result.first.id, 1009189);
      expect(result.first.name, 'Black Panther');
      expect(result.first.comicsCount, 150);

      expect(result.last.id, 1009368);
      expect(result.last.name, 'Iron Man');
      expect(result.last.comicsCount, 500);

      verify(() => mockAssetBundle.loadString('assets/json/characters.json'))
          .called(1);
    });

    test('should throw FormatException when JSON is malformed', () async {
      // Arrange
      when(() => mockAssetBundle.loadString(any()))
          .thenAnswer((_) async => '{"data": "invalid json format"');

      // Act & Assert
      expect(
        () => datasource.fetchCharacters(),
        throwsA(isA<FormatException>()),
      );

      verify(() => mockAssetBundle.loadString('assets/json/characters.json'))
          .called(1);
    });

    test(
        'should throw a TypeError when JSON structure is incorrect (missing "data")',
        () async {
      when(() => mockAssetBundle.loadString(any()))
          .thenAnswer((_) async => '{"bad_key": {"results": []}}');

      // Act & Assert
      expect(
        () => datasource.fetchCharacters(),
        throwsA(isA<NoSuchMethodError>()),
      );

      verify(() => mockAssetBundle.loadString(any())).called(1);
    });
  });
}
