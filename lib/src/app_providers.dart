import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_characters/src/modules/characters/presentation/controllers/characters_bloc.dart';
import 'package:flutter_marvel_characters/src/sl.dart';

final appProviders = [
  BlocProvider(create: (_) => CharactersBloc(getCharactersUsecase: sl())..add(FetchCharactersEvent() ))
];
