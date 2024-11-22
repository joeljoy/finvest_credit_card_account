import 'package:finvest_credit_card_account/common/category/domain/category_repository.dart';
import 'package:finvest_credit_card_account/common/category/domain/entities/category_with_details.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/credit_card_repository.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card_with_balance.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/transaction_repository.dart';
import 'package:finvest_credit_card_account/common/view_model.dart';

class HomeViewModel extends ViewModel {
  final CreditCardRepository _creditCardRepository;
  final CategoryRepository _categoryRepository;
  final TransactionRepository _transactionRepository;

  double get totalBalance => _totalBalance;
  double _totalBalance = 0.0;

  List<CreditCardWithBalance> get creditCardList => _creditCardList;
  List<CreditCardWithBalance> _creditCardList = List.empty();

  List<CategoryWithDetails> get categoryList => _categoryList;
  List<CategoryWithDetails> _categoryList = List.empty();

  List<Transaction> get transactionList => _transactionList;
  List<Transaction> _transactionList = List.empty();

  HomeViewModel({
    required CreditCardRepository creditCardRepository,
    required CategoryRepository categoryRepository,
    required TransactionRepository transactionRepository,
  })  : _creditCardRepository = creditCardRepository,
        _categoryRepository = categoryRepository,
        _transactionRepository = transactionRepository;

  void getCreditCardList() {
    _totalBalance = _creditCardRepository.getTotalBalance();
    _creditCardList = _creditCardRepository.getAllCreditCardsWithBalance();
    _categoryList = _categoryRepository.getTopCategoriesWithDetails(5);
    _transactionList = _transactionRepository.getRecentTransactions(5);
    Future.delayed(const Duration(seconds: 2), () {
      notifyListeners();
    });
  }
}
