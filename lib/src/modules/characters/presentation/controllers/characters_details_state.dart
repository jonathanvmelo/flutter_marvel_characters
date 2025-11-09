part of 'character_details_bloc.dart';

sealed class CharacterDetailsState extends Equatable {
  const CharacterDetailsState();
  @override
  List<Object?> get props => [];
}

class CharacterDetailsInitial extends CharacterDetailsState {
  const CharacterDetailsInitial();
}

class CharacterDetailsLoading extends CharacterDetailsState {
  const CharacterDetailsLoading();
}

class CharacterDetailsLoaded extends CharacterDetailsState {
  final CharacterDetailsEntity character;

  const CharacterDetailsLoaded({
    required this.character,
  });

  // Método copyWith para imutabilidade
  CharacterDetailsLoaded copyWith({
    CharacterDetailsEntity? character,
  }) {
    return CharacterDetailsLoaded(
      character: character ?? this.character,
    );
  }

  @override
  List<Object?> get props => [character];
}

class CharacterDetailsError extends CharacterDetailsState {
  final String message;

  const CharacterDetailsError(this.message);
}
