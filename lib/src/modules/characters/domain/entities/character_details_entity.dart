import 'package:marvel_characters/src/modules/characters/domain/entities/character_entity.dart';

class CharacterDetailsEntity extends CharacterEntity {
  final List<ComicItem> comics;
  final List<SeriesItem> series;
  final List<StoryItem> stories;
  final List<EventItem> events;
  final String modified;
  final String resourceURI;

  const CharacterDetailsEntity({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.comicsCount,
    required super.seriesCount,
    required super.storiesCount,
    required super.eventsCount,
    required this.comics,
    required this.series,
    required this.stories,
    required this.events,
    required this.modified,
    required this.resourceURI,
  });
}

class ComicItem {
  final String resourceURI;
  final String name;

  const ComicItem({required this.resourceURI, required this.name});
}

class SeriesItem {
  final String resourceURI;
  final String name;

  const SeriesItem({required this.resourceURI, required this.name});
}

class StoryItem {
  final String resourceURI;
  final String name;

  const StoryItem({required this.resourceURI, required this.name});
}

class EventItem {
  final String resourceURI;
  final String name;

  const EventItem({required this.resourceURI, required this.name});
}
