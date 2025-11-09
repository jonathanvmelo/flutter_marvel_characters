import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_character_details_datasource.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_character_details_datasource_impl.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_characters_datasource.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/local/local_characters_datasource_impl.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/repositories/character_details_repository_impl.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/repositories/characters_repository_impl.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/repositories/character_details_repository.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/repositories/character_repository.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/usecases/get_character_details_usecase.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/usecases/get_characters_usecase.dart';
import 'package:flutter_marvel_characters/src/modules/characters/presentation/controllers/character_details_bloc.dart';
import 'package:flutter_marvel_characters/src/modules/characters/presentation/controllers/characters_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // UseCase
  sl.registerLazySingleton(() => GetCharactersUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetCharacterDetailsUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<CharacterRepository>(
      () => CharactersRepositoryImpl(remoteDatasource: sl()));
  sl.registerLazySingleton<CharacterDetailsRepository>(
      () => CharacterDetailsRepositoryImpl(localDatasource: sl()));
  // DataSource
  sl.registerLazySingleton<LocalCharactersDatasource>(
      () => LocalCharactersDatasourceImpl(assetBundle: rootBundle));

  sl.registerLazySingleton<LocalCharacterDetailsDatasource>(
      () => LocalCharacterDetailsDatasourceImpl(assetBundle: rootBundle));

  // Bloc
  sl.registerFactory<CharactersBloc>(
      () => CharactersBloc(getCharactersUsecase: sl()));
  sl.registerFactory<CharacterDetailsBloc>(
      () => CharacterDetailsBloc(getCharacterDetailsUsecase: sl()));
  // Dio
  sl.registerLazySingleton(
      () => Dio(BaseOptions(baseUrl: 'https://gateway.marvel.com')));
}
