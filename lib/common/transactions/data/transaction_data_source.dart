import 'package:finvest_credit_card_account/common/finvest_data_helper.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/frameworks/pagination/core/paging_source.dart';
import 'package:finvest_credit_card_account/frameworks/pagination/model/load_params.dart';
import 'package:finvest_credit_card_account/frameworks/pagination/model/load_result.dart';

class TransactionDataSource implements PagingSource<int, Transaction> {
  final FinvestDataHelper _finvestDataHelper;

  TransactionDataSource({required FinvestDataHelper finvestDataHelper})
      : _finvestDataHelper = finvestDataHelper;

  int get totalTransactionsCount => _finvestDataHelper.transactions.length;

  @override
  LoadResult<int, Transaction> load(LoadParams<int> params) {
    final startKey = params.key ?? 0;
    final transactions =
        fetchTransactionByPage(offset: startKey, limit: params.loadSize);
    const prevKey = null;
    final nextKey = (startKey + params.loadSize) < totalTransactionsCount
        ? startKey + params.loadSize
        : null;
    return LoadResult.success(transactions, prevKey, nextKey);
  }

  List<Transaction> fetchTransactionByPage({
    required int offset,
    required int limit,
  }) {
    final List<Transaction> transactions = _finvestDataHelper.transactions;
    int endIndex = (offset + limit).clamp(0, transactions.length);
    return transactions.sublist(offset, endIndex);
  }

  @override
  int getRefreshKey() {
    return 0;
  }
}
