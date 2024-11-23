import 'dart:async';

import 'package:finvest_credit_card_account/frameworks/pagination/core/paging_source.dart';
import 'package:finvest_credit_card_account/frameworks/pagination/model/load_params.dart';
import 'package:finvest_credit_card_account/frameworks/pagination/model/load_result.dart';
import 'package:flutter/material.dart' as material;

class PagingController<K, T> {
  final PagingSource<K, T> pagingSource;
  final int pageSize;
  late LoadResult<K, T> _loadResult;
  final StreamController<LoadResult<K, T>> _streamController;
  Stream<LoadResult<K, T>> get data => _streamController.stream;

  PagingController({required this.pagingSource, required this.pageSize})
      : _streamController = StreamController.broadcast() {
    Future.delayed(material.Durations.short4, () {
      refresh();
    });
  }

  void append() {
    if (_loadResult is Page) {
      final key = ((_loadResult as Page).nextKey) as K;
      final params = LoadParams<K>.append(pageSize, key);
      _loadResult = pagingSource.load(params);
      _streamController.add(_loadResult);
    } else {
      return refresh();
    }
  }

  void prepend() {
    if (_loadResult is Page) {
      final key = ((_loadResult as Page).prevKey) as K;
      final params = LoadParams<K>.prepend(pageSize, key);
      _loadResult = pagingSource.load(params);
      _streamController.add(_loadResult);
    } else {
      return refresh();
    }
  }

  void refresh() {
    final key = pagingSource.getRefreshKey();
    final params = LoadParams<K>.refresh(pageSize, key);
    _loadResult = pagingSource.load(params);
    _streamController.add(_loadResult);
  }

  void dispose() {
    _streamController.close();
  }
}
