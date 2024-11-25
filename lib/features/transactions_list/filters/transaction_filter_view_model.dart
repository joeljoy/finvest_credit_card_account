// ignore_for_file: constant_identifier_names

import 'package:finvest_credit_card_account/common/category/domain/category_repository.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/transaction_repository.dart';
import 'package:finvest_credit_card_account/common/view_model.dart';
import 'package:finvest_credit_card_account/features/transactions_list/transaction_chip.dart';

class TransactionFilterViewModel extends ViewModel {
  final TransactionRepository _transactionRepository;
  final CategoryRepository _categoryRepository;

  TransactionFilterViewModel({
    required TransactionRepository transactionRepository,
    required CategoryRepository categoryRepository,
  })  : _transactionRepository = transactionRepository,
        _categoryRepository = categoryRepository;

  List<TransactionChip> getItemsForFilter(TransactionFilterTypes filter) {
    switch (filter) {
      case TransactionFilterTypes.AMOUNT:
        return List.empty();
      case TransactionFilterTypes.DATE_RANGE:
        return [
          TransactionChip(
              isActive: false,
              type: ChipType.FilterItem,
              id: "AllTime",
              label: "All time"),
          TransactionChip(
            isActive: true,
            type: ChipType.FilterItem,
            id: "CurrentMonth",
            label: "Current month",
          ),
          TransactionChip(
            isActive: false,
            type: ChipType.FilterItem,
            id: "LastMonth",
            label: "Last month",
          ),
          TransactionChip(
            isActive: false,
            type: ChipType.FilterItem,
            id: "ThisYear",
            label: "This year",
          ),
          TransactionChip(
            isActive: false,
            type: ChipType.FilterItem,
            id: "PrevYear",
            label: "Previous year",
          )
        ];
      case TransactionFilterTypes.STATUS:
        return [
              TransactionChip(
                isActive: true,
                type: ChipType.FilterItem,
                id: "All",
                label: "All",
              )
            ] +
            TransactionStatus.values.map((status) {
              return TransactionChip(
                isActive: false,
                type: ChipType.FilterItem,
                id: status.name,
                label: status.label,
              );
            }).toList(growable: false);
      case TransactionFilterTypes.TRANSACTION_TYPE:
        return [
              TransactionChip(
                isActive: true,
                type: ChipType.FilterItem,
                id: "All",
                label: "All",
              )
            ] +
            TransactionType.values.map((type) {
              return TransactionChip(
                isActive: false,
                type: ChipType.FilterItem,
                id: type.name,
                label: type.label,
              );
            }).toList(growable: false);

      case TransactionFilterTypes.CATEGORIES:
        return [
              TransactionChip(
                isActive: true,
                type: ChipType.FilterItem,
                id: "All",
                label: "All",
              )
            ] +
            _categoryRepository.getAllCategories().map((category) {
              return TransactionChip(
                  isActive: false,
                  type: ChipType.FilterItem,
                  id: category.id,
                  label: category.name);
            }).toList(growable: false);
    }
  }
}

enum TransactionFilterTypes {
  AMOUNT,
  DATE_RANGE,
  STATUS,
  TRANSACTION_TYPE,
  CATEGORIES
}

extension TransactionFilterTypesExt on TransactionFilterTypes {
  String get label {
    switch (this) {
      case TransactionFilterTypes.AMOUNT:
        return "Amount";
      case TransactionFilterTypes.DATE_RANGE:
        return "Date Range";
      case TransactionFilterTypes.STATUS:
        return "Status";
      case TransactionFilterTypes.TRANSACTION_TYPE:
        return "Transaction Type";
      case TransactionFilterTypes.CATEGORIES:
        return "Categories";
    }
  }
}
