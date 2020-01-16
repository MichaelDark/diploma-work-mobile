class AsyncState<T> {}

class LoadingState<T> extends AsyncState<T> {
  final bool isLoading;

  LoadingState(this.isLoading);
}

class SuccessState<T> extends AsyncState<T> {
  final T data;

  SuccessState(this.data);
}

class FailureState<T> extends AsyncState<T> {
  final dynamic failure;

  FailureState(this.failure);
}
