part of 'characters_bloc.dart';

sealed class CharactersState extends Equatable {
  const CharactersState();
  @override
  List<Object?> get props => [];
}

class CharacterInitial extends CharactersState {
  const CharacterInitial();
}

class CharacterLoading extends CharactersState {
  const CharacterLoading();
}

class CharactersLoaded extends CharactersState {
  final List<CharacterEntity> characters;
  final List<CharacterEntity> filteredCharacters;
  final String searchQuery;

  const CharactersLoaded({
    required this.characters,
    this.filteredCharacters = const [],
    this.searchQuery = '',
  });

  // Método copyWith para imutabilidade
  CharactersLoaded copyWith({
    List<CharacterEntity>? characters,
    List<CharacterEntity>? filteredCharacters,
    String? searchQuery,
  }) {
    return CharactersLoaded(
      characters: characters ?? this.characters,
      filteredCharacters: filteredCharacters ?? this.filteredCharacters,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [characters, filteredCharacters, searchQuery];
}

class CharacterError extends CharactersState {
  final String message;

  const CharacterError(this.message);
}

class CharacterRefreshing extends CharactersState {
  final List<CharacterEntity> currentCharacters;

  const CharacterRefreshing(this.currentCharacters);

  @override
  List<Object?> get props => [currentCharacters];
}

class CharacterRefreshSuccess extends CharactersState {
  final List<CharacterEntity> characters;

  const CharacterRefreshSuccess(this.characters);

  @override
  List<Object?> get props => [characters];
}

class CharacterRefreshFailure extends CharactersState {
  final List<CharacterEntity> currentCharacters;
  final String errorMessage;

  const CharacterRefreshFailure(this.currentCharacters, this.errorMessage);

  @override
  List<Object?> get props => [currentCharacters, errorMessage];
}
