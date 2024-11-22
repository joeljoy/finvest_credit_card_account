import 'package:finvest_credit_card_account/common/category/domain/entities/category.dart';
import 'package:finvest_credit_card_account/common/category/domain/entities/category_with_details.dart';

abstract class CategoryRepository {
  List<Category> getAllCategories();
  List<CategoryWithDetails> getTopCategoriesWithDetails(int limit);
}
