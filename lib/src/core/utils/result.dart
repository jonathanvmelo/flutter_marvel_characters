class Result<S, F> {
  final S? data;
  final F? error;

  const Result._({this.data, this.error});

  bool get isSuccess => data != null;

  factory Result.success(S data) => Result._(data: data);
  factory Result.failure(F error) => Result._(error: error);

  T when<T>({
    required T Function(S data) success,
    required T Function(F error) failure,
  }) {
    if (isSuccess) {
      return success(data as S);
    } else {
      return failure(error as F);
    }
  }
}
