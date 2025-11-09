// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'character_details_bloc.dart';

sealed class CharacterDetailsEvent {
  const CharacterDetailsEvent();
}

class FetchCharacterDetailsEvent extends CharacterDetailsEvent {
  final int id;
  const FetchCharacterDetailsEvent(
    this.id,
  );
}

// class RefreshCharactersEvent extends CharacterDetailsEvent {
//   const RefreshCharactersEvent();
// }

// class ClearRefreshErrorEvent extends CharacterDetailsEvent {
//   const ClearRefreshErrorEvent();
// }

// class FilterCharacterEvent extends CharacterDetailsEvent {
//   final String value;

//   FilterCharacterEvent(this.value);
// }
