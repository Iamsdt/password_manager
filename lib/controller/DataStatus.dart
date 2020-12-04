class DataStatus<T> {
  T data;
  DataState state;

  DataStatus(this.data, this.state);
}

enum DataState { INIT, LOADING, LOADED, FAILED, NO_INTERNET}
