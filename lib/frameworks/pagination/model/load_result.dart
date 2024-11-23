class LoadResult<K, T> {
  LoadResult._();
  factory LoadResult.success(List<T> data, K? prevKey, K? nextKey) = Page;
  factory LoadResult.error(String message) = Error;
}

class Page<K, T> extends LoadResult<K, T> {
  final List<T> data;
  final K? prevKey;
  final K? nextKey;
  Page(this.data, this.prevKey, this.nextKey) : super._();
}

class Error<K, T> extends LoadResult<K, T> {
  final String message;
  Error(this.message) : super._();
}
