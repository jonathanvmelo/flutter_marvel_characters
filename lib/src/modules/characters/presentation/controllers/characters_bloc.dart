import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_marvel_characters/src/core/utils/usecase.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_entity.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/usecases/get_characters_usecase.dart';
part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharacterEvent, CharactersState> {
  final GetCharactersUsecase getCharactersUsecase;

  CharactersBloc({required this.getCharactersUsecase})
      : super(const CharacterInitial()) {
    on<FetchCharactersEvent>(_onFetchCharacters);
    on<RefreshCharactersEvent>(_onRefreshCharacters);
    on<ClearRefreshErrorEvent>(_onClearRefreshError);
  }

  Future<void> _onFetchCharacters(
    FetchCharactersEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(const CharacterLoading());

    final result = await getCharactersUsecase.call(NoParams());

    result.when(
      success: (characters) {
        emit(CharacterLoaded(characters));
      },
      failure: (error) {
        emit(CharacterError(error.message));
      },
    );
  }

  Future<void> _onRefreshCharacters(
    RefreshCharactersEvent event,
    Emitter<CharactersState> emit,
  ) async {
    final currentState = state;

    if (currentState is! CharacterLoaded &&
        currentState is! CharacterRefreshing &&
        currentState is! CharacterRefreshFailure) {
      return;
    }

    List<CharacterEntity> currentCharacters;

    if (currentState is CharacterLoaded) {
      currentCharacters = currentState.characters;
    } else if (currentState is CharacterRefreshing) {
      currentCharacters = currentState.currentCharacters;
    } else if (currentState is CharacterRefreshFailure) {
      currentCharacters = currentState.currentCharacters;
    } else {
      return;
    }

    emit(CharacterRefreshing(currentCharacters));

    final result = await getCharactersUsecase.call(NoParams());

    result.when(
      success: (characters) {
        emit(CharacterRefreshSuccess(characters));

        Future.delayed(const Duration(milliseconds: 100), () {
          if (!isClosed) {
            emit(CharacterLoaded(characters));
          }
        });
      },
      failure: (error) {
        emit(CharacterRefreshFailure(currentCharacters, error.message));
      },
    );
  }

  void _onClearRefreshError(
    ClearRefreshErrorEvent event,
    Emitter<CharactersState> emit,
  ) {
    if (state is CharacterRefreshFailure) {
      final currentState = state as CharacterRefreshFailure;
      emit(CharacterLoaded(currentState.currentCharacters));
    }
  }
}
