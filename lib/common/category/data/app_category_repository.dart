import 'package:finvest_credit_card_account/common/category/domain/category_repository.dart';
import 'package:finvest_credit_card_account/common/category/domain/entities/category.dart';
import 'package:finvest_credit_card_account/common/category/domain/entities/category_with_details.dart';
import 'package:finvest_credit_card_account/common/finvest_data_helper.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';

class AppCategoryRepository implements CategoryRepository {
  final FinvestDataHelper _finvestDataHelper;

  AppCategoryRepository({required FinvestDataHelper finvestDataHelper})
      : _finvestDataHelper = finvestDataHelper;

  @override
  List<Category> getAllCategories() {
    return _finvestDataHelper.categoryIds.map((id) {
      return Category(id: id, name: id);
    }).toList(growable: false);
  }

  @override
  List<CategoryWithDetails> getTopCategoriesWithDetails(int limit) {
    final categoryToValueMap = _calculateCategoryTotals();
    final categoryWithDetails = getAllCategories().map((category) {
      final total = categoryToValueMap[category.id]!.$1;
      final percentage = categoryToValueMap[category.id]!.$2;
      return CategoryWithDetails(
          category: category, spendPercentage: percentage, totalValue: total);
    }).toList(growable: false);
    return categoryWithDetails;
  }

  Map<String, (double, double)> _calculateCategoryTotals() {
    final List<Transaction> transactions = _finvestDataHelper.transactions;
    final Map<String, double> categoryTotals = {};

    for (var transaction in transactions) {
      categoryTotals.update(
        transaction.categoryId,
        (currentTotal) => currentTotal + transaction.value,
        ifAbsent: () => transaction.value,
      );
    }
    final double totalSpends =
        categoryTotals.values.fold(0.0, (sum, value) => sum + value);
    final categoryDetails = categoryTotals.map((category, total) {
      final percentage = (total / totalSpends) * 100;
      return MapEntry(category, (total, percentage));
    });
    return categoryDetails;
  }
}
