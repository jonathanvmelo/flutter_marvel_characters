import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final int comicsCount;
  final int seriesCount;
  final int storiesCount;
  final int eventsCount;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.comicsCount,
    required this.seriesCount,
    required this.storiesCount,
    required this.eventsCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        comicsCount,
        seriesCount,
        storiesCount,
        eventsCount,
      ];
}
