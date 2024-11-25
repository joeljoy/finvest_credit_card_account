import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/common/transactions/transaction_ui_util.dart';
import 'package:finvest_credit_card_account/features/transactions_list/filters/transaction_filter_view.dart';
import 'package:finvest_credit_card_account/features/transactions_list/filters/transaction_filter_view_model.dart';
import 'package:finvest_credit_card_account/features/transactions_list/transaction_chip.dart';
import 'package:finvest_credit_card_account/features/transactions_list/transaction_list_view_model.dart';
import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/app_shadows.dart';
import 'package:finvest_credit_card_account/theme/app_spacing.dart';
import 'package:finvest_credit_card_account/theme/components/app_chip.dart';
import 'package:finvest_credit_card_account/theme/components/app_divider.dart';
import 'package:finvest_credit_card_account/theme/components/financial_tile.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:finvest_credit_card_account/utils/currency_utils.dart';
import 'package:finvest_credit_card_account/utils/image_logo_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class TransactionListView extends StatefulWidget {
  const TransactionListView({super.key});

  @override
  State<TransactionListView> createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<TransactionListViewModel>(context, listen: false).init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.chevron_back),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(CupertinoIcons.search),
          )
        ],
        backgroundColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        iconTheme: const IconThemeData(size: 20),
        actionsIconTheme: const IconThemeData(size: 24),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.lightBlue,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.lightBlue,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Consumer<TransactionListViewModel>(
        builder: (context, vm, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Heading(),
              _CreditCardDropDown(vm: vm),
              _SortAndFilterChips(vm: vm),
              Expanded(child: _Transactions(viewModel: vm)),
            ],
          );
        },
      ),
      backgroundColor: AppColors.lightBlue,
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.small,
        right: AppSpacing.small,
      ),
      child: Text(
        "Transactions",
        style: context.typography.heading
            .copyWith(color: AppColors.teal, fontSize: 32, height: 36 / 32),
      ),
    );
  }
}

class _CreditCardDropDown extends StatefulWidget {
  final TransactionListViewModel vm;
  const _CreditCardDropDown({super.key, required this.vm});

  @override
  State<_CreditCardDropDown> createState() => _CreditCardDropDownState();
}

class _CreditCardDropDownState extends State<_CreditCardDropDown> {
  CardSelector? _selectedCard;

  @override
  void initState() {
    _selectedCard = widget.vm.cardList.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.white, width: 1),
    );
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.xsmall,
        left: AppSpacing.xsmall,
        right: AppSpacing.xsmall,
      ),
      child: DropdownButtonFormField<CardSelector>(
        value: _selectedCard,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.grey,
          border: border,
          enabledBorder: border,
          focusedBorder: border,
        ),
        icon: const Icon(
          CupertinoIcons.chevron_down,
          color: AppColors.teal,
          size: 16,
        ),
        dropdownColor: AppColors.grey,
        items: widget.vm.cardList.map((card) {
          return DropdownMenuItem<CardSelector>(
              value: card,
              child: Text(
                card.label,
                style: context.typography.subHeading2.copyWith(
                    color: AppColors.teal, fontSize: 14, height: 20 / 14),
              ));
        }).toList(growable: false),
        onChanged: (card) {
          setState(() {
            _selectedCard = card;
          });
        },
      ),
    );
  }
}

class _SortAndFilterChips extends StatelessWidget {
  final TransactionListViewModel vm;
  const _SortAndFilterChips({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.small,
        left: AppSpacing.xsmall,
        right: AppSpacing.xsmall,
      ),
      child: SizedBox(
        height: 32,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final chip = vm.chips[index];
            return AppChip(
              label: chip.label,
              isSelected: chip.isActive,
              activeBackgroundColor: AppColors.grey,
              inactiveBackgroundColor: AppColors.grey,
              activeBorderColor: AppColors.teal,
              inactiveBorderColor: AppColors.white,
              counter: vm.getCounterForChipIfAny(chip),
              onTap: () => _handleChipTap(context, chip),
              iconBuilder: (_) => getIconForChip(chip),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: AppSpacing.small,
            );
          },
          itemCount: vm.chips.length,
        ),
      ),
    );
  }

  Widget getIconForChip(TransactionChip chip) {
    switch (chip.type) {
      case ChipType.Sort:
        return const Icon(
          CupertinoIcons.chevron_down,
          size: 12,
          color: AppColors.teal,
        );
      case ChipType.Filter:
        return SvgPicture.asset(
          'assets/ic_filter.svg',
          width: 12,
          height: 12,
          colorFilter: const ColorFilter.mode(AppColors.teal, BlendMode.srcIn),
        );
      case ChipType.FilterItem:
        if (chip.isActive) {
          return const Icon(
            Icons.close,
            size: 12,
            color: AppColors.teal,
          );
        } else {
          return const SizedBox();
        }
    }
  }

  void _handleChipTap(BuildContext context, TransactionChip chip) async {
    switch (chip.type) {
      case ChipType.Filter:
        final List<String>? filters = await showModalBottomSheet<List<String>>(
          context: context,
          builder: (context) {
            return ChangeNotifierProvider<TransactionFilterViewModel>(
              create: (context) => TransactionFilterViewModel(
                transactionRepository: GetIt.instance.get(),
                categoryRepository: GetIt.instance.get(),
              ),
              child: const TransactionFilterView(),
            );
          },
          backgroundColor: AppColors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20), // Top corners radius
            ),
          ),
        );
        if (filters != null) {
          vm.setFilters(filters);
        }
      default:
      //Other FilterType cases to be handled later.
    }
  }
}

class _Transactions extends StatelessWidget {
  final TransactionListViewModel viewModel;
  const _Transactions({super.key, required this.viewModel});

  List<Transaction> get transactions => viewModel.transactions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.small,
        left: AppSpacing.xsmall,
        right: AppSpacing.xsmall,
      ),
      child: Container(
        padding: const EdgeInsets.only(
            top: AppSpacing.small,
            left: AppSpacing.small,
            right: AppSpacing.small),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppShadows.container,
          border: Border.all(
            color: AppColors.white,
            width: 1.0,
          ),
        ),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              viewModel.loadMore();
            }
            return true;
          },
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              final amount =
                  CurrencyUtils.getFormattedAmount(amount: transaction.value);
              return FinancialTile(
                integral: amount.$1,
                decimal: amount.$2,
                title: transaction.merchantName,
                description: transaction.description,
                imageSource:
                    ImageLogoUtil.getLogoForName(transaction.merchantName),
              );
            },
            separatorBuilder: (_, __) => const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: AppSpacing.small),
                AppDivider(),
                SizedBox(height: AppSpacing.small),
              ],
            ),
            itemCount: transactions.length,
          ),
        ),
      ),
    );
  }
}
