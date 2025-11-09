import 'package:marvel_characters/src/core/errors/failures.dart';
import 'package:marvel_characters/src/core/utils/result.dart';

abstract class Usecase<Type, Params> {
  Future<Result<Type, Failure>> call(Params params);
}

class NoParams {}
