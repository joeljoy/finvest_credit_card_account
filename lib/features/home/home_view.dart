import 'package:finvest_credit_card_account/common/category/domain/entities/category_with_details.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card_with_balance.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/features/home/home_view_model.dart';
import 'package:finvest_credit_card_account/features/home/widgets/category_home_widget.dart';
import 'package:finvest_credit_card_account/features/home/widgets/credit_card_home_widget.dart';
import 'package:finvest_credit_card_account/features/home/widgets/transaction_home_widget.dart';
import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/app_spacing.dart';
import 'package:finvest_credit_card_account/theme/components/amount_text_view.dart';
import 'package:finvest_credit_card_account/theme/components/chart_painter.dart';
import 'package:finvest_credit_card_account/theme/components/period_selector_bar_widget.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:finvest_credit_card_account/utils/currency_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<double> dataPoints = [10, 20, 15, 30, 25, 35, 40, 20, 10, 30];
  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).getCreditCardList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey2,
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.chevron_back),
        title: const Text("Credit Card"),
        titleSpacing: 0.0,
        titleTextStyle: context.typography.subHeading1
            .copyWith(fontSize: 18, color: AppColors.teal),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(CupertinoIcons.info_circle),
          )
        ],
        backgroundColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        iconTheme: const IconThemeData(size: 20),
        actionsIconTheme: const IconThemeData(size: 24),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, homeVm, child) {
          return _HomeBody(
            totalBalance: homeVm.totalBalance,
            creditCardList: homeVm.creditCardList,
            categoryList: homeVm.categoryList,
            transactionList: homeVm.transactionList,
            chartDataPoints: dataPoints,
          );
        },
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  final double totalBalance;
  final List<CreditCardWithBalance> creditCardList;
  final List<CategoryWithDetails> categoryList;
  final List<Transaction> transactionList;
  final List<double> chartDataPoints;

  const _HomeBody({
    super.key,
    required this.totalBalance,
    required this.creditCardList,
    required this.categoryList,
    required this.transactionList,
    required this.chartDataPoints,
  });

  @override
  Widget build(BuildContext context) {
    final totalBalanceFormatted =
        CurrencyUtils.getFormattedAmount(amount: totalBalance);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BalanceWidget(totalBalanceFormatted: totalBalanceFormatted),
          _ChartWidget(chartDataPoints: chartDataPoints),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.small),
            child: CreditCardHomeWidget(creditCardList: creditCardList),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.small),
            child: CategoryHomeWidget(categories: categoryList),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.small),
            child: TransactionHomeWidget(transactions: transactionList),
          )
        ],
      ),
    );
  }
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget({
    super.key,
    required this.totalBalanceFormatted,
  });

  final (String, String) totalBalanceFormatted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "BALANCE DUE",
            style: context.typography.label.copyWith(color: AppColors.grey3),
          ),
          const SizedBox(height: AppSpacing.small),
          AmountTextView(
            integral: totalBalanceFormatted.$1,
            decimal: totalBalanceFormatted.$2,
            styleBuilder: (context) =>
                context.typography.heading.copyWith(color: AppColors.teal),
          ),
        ],
      ),
    );
  }
}

class _ChartWidget extends StatelessWidget {
  const _ChartWidget({
    super.key,
    required this.chartDataPoints,
  });

  final List<double> chartDataPoints;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          CustomPaint(
            painter: ChartPainter(chartDataPoints),
            size: const Size.fromHeight(240),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.small),
              child: PeriodSelectorBarWidget(
                defaultPeriodId: PeriodId.SIX_MONTH,
                onPeriodChanged: (period) {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
