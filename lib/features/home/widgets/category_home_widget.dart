import 'package:finvest_credit_card_account/common/category/domain/entities/category_with_details.dart';
import 'package:finvest_credit_card_account/features/home/widgets/home_component_template_widget.dart';
import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/components/app_text_button.dart';
import 'package:finvest_credit_card_account/utils/image_logo_util.dart';
import 'package:flutter/material.dart';

class CategoryHomeWidget extends HomeComponentTemplateWidget {
  final List<CategoryWithDetails> categories;
  const CategoryHomeWidget({super.key, required this.categories});

  @override
  String getTitle() {
    return "Top categories";
  }

  @override
  List<HomeComponentWidgetItem> getItems() {
    return categories.map((category) {
      final description = '${category.spendPercentage.truncate()}% of spends';
      return HomeComponentWidgetItem(
        title: category.category.name,
        description: description,
        amount: category.totalValue,
        imageSource: ImageLogoUtil.getLogoForName(category.category.name),
      );
    }).toList(growable: false);
  }

  @override
  int getItemsCount() {
    return categories.length;
  }

  @override
  Widget getFooterButton() {
    return AppTextButton(
      label: "See all categories",
      trailingIcon:
          const Icon(Icons.navigate_next, size: 16, color: AppColors.blue),
      onTap: () {},
    );
  }
}
