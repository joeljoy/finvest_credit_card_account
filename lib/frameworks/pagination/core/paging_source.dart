import 'package:finvest_credit_card_account/frameworks/pagination/model/load_params.dart';
import 'package:finvest_credit_card_account/frameworks/pagination/model/load_result.dart';

abstract class PagingSource<K, T> {
  LoadResult<K, T> load(LoadParams<K> params);
  K getRefreshKey();
}
