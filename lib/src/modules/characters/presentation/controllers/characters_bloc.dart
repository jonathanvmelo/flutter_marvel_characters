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
    on<FilterCharacterEvent>(_filterCharacter);
  }

  Future<void> _onFetchCharacters(
    FetchCharactersEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(const CharacterLoading());

    final result = await getCharactersUsecase.call(NoParams());

    result.when(
      success: (characters) {
        emit(CharactersLoaded(
          characters: characters,
          filteredCharacters: characters,
          searchQuery: '',
        ));
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

    if (currentState is! CharactersLoaded) {
      return;
    }

    emit(CharacterRefreshing(currentState.characters));

    final result = await getCharactersUsecase.call(NoParams());

    result.when(
      success: (characters) {
        // Aplica o filtro atual aos novos dados
        final currentSearchQuery = currentState.searchQuery;
        List<CharacterEntity> filteredCharacters;

        if (currentSearchQuery.isEmpty) {
          filteredCharacters = characters;
        } else {
          filteredCharacters = characters.where((character) {
            return character.name.toLowerCase().contains(currentSearchQuery);
          }).toList();
        }

        emit(CharactersLoaded(
          characters: characters,
          filteredCharacters: filteredCharacters,
          searchQuery: currentSearchQuery,
        ));
      },
      failure: (error) {
        emit(CharacterRefreshFailure(currentState.characters, error.message));

        Future.delayed(const Duration(seconds: 3), () {
          if (!isClosed && state is CharacterRefreshFailure) {
            add(const ClearRefreshErrorEvent());
          }
        });
      },
    );
  }

  void _onClearRefreshError(
    ClearRefreshErrorEvent event,
    Emitter<CharactersState> emit,
  ) {
    if (state is CharacterRefreshFailure) {
      final currentState = state as CharacterRefreshFailure;
      emit(CharactersLoaded(characters: currentState.currentCharacters));
    }
  }

  void _filterCharacter(
    FilterCharacterEvent event,
    Emitter<CharactersState> emit,
  ) async {
    final currentState = state;

    if (currentState is! CharactersLoaded) {
      return;
    }
    final searchQuery = event.value.trim().toLowerCase();

    if (searchQuery.isEmpty) {
      emit(currentState.copyWith(
        filteredCharacters: currentState.characters,
        searchQuery: '',
      ));
      return;
    }

    final filteredCharacters = currentState.characters.where((character) {
      return character.name.toLowerCase().contains(searchQuery);
    }).toList();

    emit(currentState.copyWith(
      filteredCharacters: filteredCharacters,
      searchQuery: searchQuery,
    ));
  }
}
