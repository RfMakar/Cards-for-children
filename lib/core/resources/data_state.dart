abstract class DataState<T> {
  T? data;
  bool success;
  String? message;
  DataState(this.data, this.success, this.message);
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data, true, null);
}

class DataFailed<T> extends DataState<T> {
  DataFailed(String? message) : super(null, false, message);
}