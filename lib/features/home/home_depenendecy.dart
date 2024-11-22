import 'package:finvest_credit_card_account/common/category/data/app_category_repository.dart';
import 'package:finvest_credit_card_account/common/category/domain/category_repository.dart';
import 'package:finvest_credit_card_account/common/credit_card/data/app_credit_card_repository.dart';
import 'package:finvest_credit_card_account/common/credit_card/data/credit_card_data_source.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/credit_card_repository.dart';
import 'package:finvest_credit_card_account/common/finvest_data_helper.dart';
import 'package:finvest_credit_card_account/common/transactions/data/app_transaction_repository.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/transaction_repository.dart';
import 'package:get_it/get_it.dart';

class HomeDepenendecy {
  static void inject() {
    final getIt = GetIt.instance;
    getIt.registerSingleton(FinvestDataHelper());
    getIt.registerFactory(
      () => CreditCardDataSource(finvestDataHelper: getIt()),
    );
    getIt.registerFactory<CreditCardRepository>(
      () => AppCreditCardRepository(creditCardDataSource: getIt()),
    );
    getIt.registerFactory<CategoryRepository>(
      () => AppCategoryRepository(finvestDataHelper: getIt()),
    );
    getIt.registerFactory<TransactionRepository>(
      () => AppTransactionRepository(finvestDataHelper: getIt()),
    );
  }
}
