
///Common class to transfer data
class StateModel<T> {
  StateModel._();

  factory StateModel.success(T value) = SuccessState<T>;

  factory StateModel.error(T msg) = ErrorState<T>;
}

/// transfer data with errors
class ErrorState<T> extends StateModel<T> {
  ///contain error message
  ErrorState(this.msg) : super._();
  ///message
  final T msg;
}

/// transfer success data object
class SuccessState<T> extends StateModel<T> {
  ///contain data object
  SuccessState(this.value) : super._();
  /// value
  final T value;
}
