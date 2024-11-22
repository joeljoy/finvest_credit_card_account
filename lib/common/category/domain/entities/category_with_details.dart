import 'package:finvest_credit_card_account/common/category/domain/entities/category.dart';

class CategoryWithDetails {
  final Category category;
  final double spendPercentage;
  final double totalValue;

  CategoryWithDetails({
    required this.category,
    required this.spendPercentage,
    required this.totalValue,
  });
}
