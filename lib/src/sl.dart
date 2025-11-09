import 'package:dio/dio.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/characters_remote_datasource.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/datasources/characters_remote_datasource_impl.dart';
import 'package:flutter_marvel_characters/src/modules/characters/data/repositories/characters_repository_impl.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/repositories/character_repository.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/usecases/get_characters_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // UseCase
  sl.registerLazySingleton(() => GetCharactersUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<CharacterRepository>(
      () => CharactersRepositoryImpl(remoteDatasource: sl()));
  // DataSource
  sl.registerLazySingleton<CharactersRemoteDatasource>(
      () => CharactersRemoteDatasourceImpl(dio: sl()));
 
  // Dio
  sl.registerLazySingleton(() => Dio(BaseOptions(baseUrl: 'https://gateway.marvel.com')));
}
