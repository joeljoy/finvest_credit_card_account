import 'package:finvest_credit_card_account/common/category/domain/entities/category_with_details.dart';
import 'package:finvest_credit_card_account/common/credit_card/domain/entities/credit_card_with_balance.dart';
import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/features/home/home_view_model.dart';
import 'package:finvest_credit_card_account/features/home/widgets/category_home_widget.dart';
import 'package:finvest_credit_card_account/features/home/widgets/credit_card_home_widget.dart';
import 'package:finvest_credit_card_account/features/home/widgets/transaction_home_widget.dart';
import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/app_spacing.dart';
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
      body: Consumer<HomeViewModel>(
        builder: (context, homeVm, child) {
          return _HomeBody(
            creditCardList: homeVm.creditCardList,
            categoryList: homeVm.categoryList,
            transactionList: homeVm.transactionList,
          );
        },
      ),
    );

    // Container(
    //   padding: const EdgeInsets.all(16),
    //   color: AppColors.lightBlue,
    //   child: Stack(
    //     children: [
    //       Container(
    //         height: 240, // Adjust height as needed
    //         width: double.infinity,
    //         child: CustomPaint(
    //           painter: ChartPainter(dataPoints),
    //         ),
    //       ),
    //       PeriodSelectorBarWidget(
    //           defaultPeriodId: PeriodId.SIX_MONTH, onPeriodChanged: (period) {})
    //     ],
    //   ),
    //   // Consumer<HomeViewModel>(
    //   //   builder: (context, value, child) {
    //   //     return CreditCardListWidget(creditCardList: value.creditCardList);
    //   //   },
    //   // ),
    // );
  }
}

class _HomeBody extends StatelessWidget {
  final List<CreditCardWithBalance> creditCardList;
  final List<CategoryWithDetails> categoryList;
  final List<Transaction> transactionList;

  const _HomeBody({
    super.key,
    required this.creditCardList,
    required this.categoryList,
    required this.transactionList,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
