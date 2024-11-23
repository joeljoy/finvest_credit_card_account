// ignore_for_file: constant_identifier_names

class LoadParams<K> {
  int loadSize;
  K? key;
  LoadType type;
  LoadParams._({required this.loadSize, required this.key, required this.type});

  factory LoadParams.refresh(int loadSize, K? key) = RefreshParams;
  factory LoadParams.append(int loadSize, K key) = AppendParams;
  factory LoadParams.prepend(int loadSize, K key) = PrependParams;
}

class RefreshParams<K> extends LoadParams<K> {
  RefreshParams(int loadSize, K? key)
      : super._(loadSize: loadSize, key: key, type: LoadType.REFRESH);
}

class AppendParams<K> extends LoadParams<K> {
  AppendParams(int loadSize, K key)
      : super._(loadSize: loadSize, key: key, type: LoadType.APPEND);
}

class PrependParams<K> extends LoadParams<K> {
  PrependParams(int loadSize, K key)
      : super._(loadSize: loadSize, key: key, type: LoadType.PREPEND);
}

enum LoadType {
  REFRESH,
  APPEND,
  PREPEND,
}
