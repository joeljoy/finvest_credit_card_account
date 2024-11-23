import 'package:finvest_credit_card_account/common/category/domain/category_repository.dart';
import 'package:finvest_credit_card_account/common/category/domain/entities/category_with_details.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/credit_card_repository.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card_with_balance.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/transaction_repository.dart';
import 'package:finvest_credit_card_account/common/view_model.dart';
import 'package:finvest_credit_card_account/theme/components/period_selector_bar_widget.dart';

class HomeViewModel extends ViewModel {
  final CreditCardRepository _creditCardRepository;
  final CategoryRepository _categoryRepository;
  final TransactionRepository _transactionRepository;

  double get totalBalance => _totalBalance;
  double _totalBalance = 0.0;

  List<double> get balanceGraphDataPoints => _balanceGraphDataPoints;
  List<double> _balanceGraphDataPoints = [];

  List<CreditCardWithBalance> get creditCardList => _creditCardList;
  List<CreditCardWithBalance> _creditCardList = List.empty();

  List<CategoryWithDetails> get categoryList => _categoryList;
  List<CategoryWithDetails> _categoryList = List.empty();

  List<Transaction> get transactionList => _transactionList;
  List<Transaction> _transactionList = List.empty();

  Period _selectedPeriod = Period(id: PeriodId.SIX_MONTH, label: "6M");

  HomeViewModel({
    required CreditCardRepository creditCardRepository,
    required CategoryRepository categoryRepository,
    required TransactionRepository transactionRepository,
  })  : _creditCardRepository = creditCardRepository,
        _categoryRepository = categoryRepository,
        _transactionRepository = transactionRepository;

  void getAllDetails() {
    getCreditCardDetails();
    _categoryList = _categoryRepository.getTopCategoriesWithDetails(5);
    _transactionList = _transactionRepository.getRecentTransactions(5);
    notifyListeners();
  }

  void getCreditCardDetails() {
    _balanceGraphDataPoints = _creditCardRepository.getBalances();
    if (_selectedPeriod.id == PeriodId.ALL) {
      _totalBalance = _creditCardRepository.getTotalBalance();
      _creditCardList = _creditCardRepository.getAllCreditCardsWithBalance();
    } else {
      final start = _selectedPeriod.startTime();
      final end = _selectedPeriod.endTime();
      _totalBalance = _creditCardRepository.getTotalBalanceForPeriod(
          start: start, end: end);
      _creditCardList = _creditCardRepository
          .getAllCreditCardsWithBalanceForPeriod(start: start, end: end);
    }
  }

  void onPeriodChanged(Period period) {
    if (_selectedPeriod.id != period.id) {
      _selectedPeriod = period;
      getAllDetails();
    }
  }
}
