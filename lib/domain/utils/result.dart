class Result<T> {
  final T? data;
  final Object? error;

  Result.success(this.data) : error = null;
  Result.failure(this.error) : data = null;

  bool get isSuccess => data != null;
  bool get isFailure => error != null;
}

extension ResultHandler on Result {
  void onSuccess(Function onSuccess) {
    onSuccess.call();
  }

  void onFailure(Function onFailure) {
    onFailure.call();
  }

  void processResult({
    required Function onSuccess,
    required Function onFailure,
  }) {
    if (isSuccess) {
      this.onSuccess(onSuccess);
    }
    if (isFailure) {
      this.onFailure(onFailure);
    }
  }
}
