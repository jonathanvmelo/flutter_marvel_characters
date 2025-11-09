import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_details_entity.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/usecases/get_character_details_usecase.dart';
part 'characters_details_event.dart';
part 'characters_details_state.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  final GetCharacterDetailsUsecase getCharacterDetailsUsecase;

  CharacterDetailsBloc({required this.getCharacterDetailsUsecase})
      : super(const CharacterDetailsInitial()) {
    on<FetchCharacterDetailsEvent>(_onFetchCharacterDetails);
  }

  Future<void> _onFetchCharacterDetails(
    FetchCharacterDetailsEvent event,
    Emitter<CharacterDetailsState> emit,
  ) async {
    emit(const CharacterDetailsLoading());

    final result = await getCharacterDetailsUsecase.call(event.id);

    result.when(
      success: (characters) {
        emit(CharacterDetailsLoaded(
          character: characters,
        ));
      },
      failure: (error) {
        emit(CharacterDetailsError(error.message));
      },
    );
  }
}
