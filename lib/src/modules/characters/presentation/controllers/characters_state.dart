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

class CharacterLoaded extends CharactersState {
  final List<CharacterEntity> characters;

  const CharacterLoaded(this.characters);

  @override
  List<Object?> get props => [characters];
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
