// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

import 'package:finvest_credit_card_account/common/credit_card/domain/credit_card_repository.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/transaction_repository.dart';
import 'package:finvest_credit_card_account/common/view_model.dart';
import 'package:finvest_credit_card_account/features/transactions_list/transaction_chip.dart';
import 'package:finvest_credit_card_account/frameworks/pagination/core/paging_controller.dart';
import 'package:finvest_credit_card_account/frameworks/pagination/model/load_result.dart';

class TransactionListViewModel extends ViewModel {
  static const PAGE_SIZE = 15;
  final TransactionRepository _transactionRepository;
  final CreditCardRepository _creditCardRepository;

  PagingController<int, Transaction>? _pagingController;
  bool _isLoadMore = false;

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  List<Transaction> get transactions => _transactions;
  List<Transaction> _transactions = List.empty();

  List<TransactionChip> get chips => _defaultChips + _applidedFilterChips;
  List<TransactionChip> _defaultChips = [
    TransactionChip(
        id: "Sort", label: "Sort by", isActive: false, type: ChipType.Sort),
    TransactionChip(
        id: "Filters",
        label: "Filters",
        isActive: false,
        type: ChipType.Filter),
    TransactionChip(
        id: "Top transaction",
        label: "Top transaction",
        isActive: false,
        type: ChipType.FilterItem),
  ];
  List<TransactionChip> _applidedFilterChips = [];

  List<CardSelector> get cardList => _cardList;
  List<CardSelector> _cardList = [
    CardSelector(id: "ALL", label: "All credit cards")
  ];

  TransactionListViewModel({
    required TransactionRepository transactionRepository,
    required CreditCardRepository creditCardRepository,
  })  : _transactionRepository = transactionRepository,
        _creditCardRepository = creditCardRepository;

  void init() {
    final allCards = _creditCardRepository.getAllCreditCards();
    _cardList += allCards.map((card) {
      return CardSelector(id: card.id, label: card.name);
    }).toList(growable: false);

    _initialiseDataSource();
  }

  void _initialiseDataSource() {
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
      notifyListeners();


      //artificila delay
      Future.delayed(const Duration(seconds: 2), () {
        _pagingController!.append();
      });
    }
  }

  int? getCounterForChipIfAny(TransactionChip chip) {
    if (chip.type == ChipType.Filter) {
      return _applidedFilterChips.isNotEmpty
          ? _applidedFilterChips.length
          : null;
    } else {
      return null;
    }
  }

  void setFilters(List<String> filters) {
    if (filters.isEmpty) {
      _defaultChips = _defaultChips.map((chip) {
        if (chip.type == ChipType.Filter) {
          return TransactionChip(
            id: "Filters",
            label: "Filters",
            isActive: false,
            type: ChipType.Filter,
          );
        } else {
          return chip;
        }
      }).toList(growable: false);
      _applidedFilterChips = List.empty();
    } else {
      _defaultChips = _defaultChips.map((chip) {
        if (chip.type == ChipType.Filter) {
          return TransactionChip(
              id: "Filters",
              label: "Filters",
              isActive: true,
              type: ChipType.Filter);
        } else {
          return chip;
        }
      }).toList(growable: false);
      _applidedFilterChips = filters.map((filter) {
        return TransactionChip(
            isActive: true,
            type: ChipType.FilterItem,
            id: filter,
            label: filter);
      }).toList(growable: false);
    }
    notifyListeners();
  }
}

class CardSelector {
  String id;
  String label;

  CardSelector({
    required this.id,
    required this.label,
  });
}
