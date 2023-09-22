class Result<T> {
  final T? value;
  final String? error;

  Result.success(this.value) : error = null;
  Result.error(this.error) : value = null;

  bool get isSuccess => error == null;
}
