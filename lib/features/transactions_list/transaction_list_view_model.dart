// ignore_for_file: constant_identifier_names

import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/transaction_repository.dart';
import 'package:finvest_credit_card_account/common/view_model.dart';
import 'package:finvest_credit_card_account/frameworks/pagination/core/paging_controller.dart';
import 'package:finvest_credit_card_account/frameworks/pagination/model/load_result.dart';

class TransactionListViewModel extends ViewModel {
  static const PAGE_SIZE = 15;
  final TransactionRepository _transactionRepository;

  PagingController<int, Transaction>? _pagingController;
  bool _isLoadMore = false;
  bool _isLoading = false;

  List<Transaction> get transactions => _transactions;
  List<Transaction> _transactions = List.empty();

  TransactionListViewModel(
      {required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  void initialiseDataSource() {
    final pagingSource = _transactionRepository.createDataSource();
    _pagingController =
        PagingController(pagingSource: pagingSource, pageSize: PAGE_SIZE);
    _pagingController!.data.listen((result) {
      if (result is Page<int, Transaction>) {
        _transactions += result.data;
        _isLoadMore = result.nextKey != null;
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  void loadMore() {
    if (_isLoading == false && _isLoadMore) {
      _isLoading = true;
      _pagingController!.append();
    }
  }
}
