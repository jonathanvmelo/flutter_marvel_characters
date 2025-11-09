import 'package:flutter_marvel_characters/src/modules/characters/domain/usecases/get_characters_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // UseCase
  sl.registerLazySingleton(() => GetCharactersUsecase(repository: sl()));

  // Repository

  // DataSource
}
