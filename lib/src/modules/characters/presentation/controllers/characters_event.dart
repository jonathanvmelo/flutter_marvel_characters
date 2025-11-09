part of 'characters_bloc.dart';

sealed class CharacterEvent {
  const CharacterEvent();
}

class FetchCharactersEvent extends CharacterEvent {
  const FetchCharactersEvent();
}

class RefreshCharactersEvent extends CharacterEvent {
  const RefreshCharactersEvent();
}

class ClearRefreshErrorEvent extends CharacterEvent {
  const ClearRefreshErrorEvent();
}

class FilterCharacterEvent extends CharacterEvent {
  final String value;

  FilterCharacterEvent(this.value);
}
