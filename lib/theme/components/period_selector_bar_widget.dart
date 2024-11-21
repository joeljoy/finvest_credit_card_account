// ignore_for_file: constant_identifier_names

import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/app_shadows.dart';
import 'package:finvest_credit_card_account/theme/app_spacing.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class PeriodSelectorBarWidget extends StatefulWidget {
  final List<Period>? periods;
  final PeriodId defaultPeriodId;
  final ValueChanged<Period> onPeriodChanged;

  const PeriodSelectorBarWidget(
      {super.key,
      this.periods,
      required this.onPeriodChanged,
      required this.defaultPeriodId});

  List<Period> get _periods => periods ?? defaultPeriods;

  @override
  State<PeriodSelectorBarWidget> createState() =>
      _PeriodSelectorBarWidgetState();
}

class _PeriodSelectorBarWidgetState extends State<PeriodSelectorBarWidget> {
  late PeriodId _selectedPeriod;

  @override
  void initState() {
    _selectedPeriod = widget.defaultPeriodId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double totalWidth =
          constraints.maxWidth - 32; //vertical padding of the ListView
      int itemCount = widget._periods.length;
      double itemWidth = 40.0;
      double totalSpacing = totalWidth - (itemCount * itemWidth);
      double spacing = totalSpacing / (itemCount - 1);

      return Container(
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: AppShadows.container,
          ),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.xsmall, horizontal: AppSpacing.small),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _PeriodSelectorCell(
              period: widget._periods[index],
              selectedPeriodId: _selectedPeriod,
              onTap: (period) {
                setState(() {
                  _selectedPeriod = period.id;
                });
                widget.onPeriodChanged(period);
              },
            ),
            separatorBuilder: (context, index) => SizedBox(width: spacing),
            itemCount: widget._periods.length,
          ));
      ;
    });
  }
}

class _PeriodSelectorCell extends StatelessWidget {
  final Period period;
  final PeriodId selectedPeriodId;
  final ValueChanged<Period> onTap;

  const _PeriodSelectorCell({
    super.key,
    required this.period,
    required this.onTap,
    required this.selectedPeriodId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(period),
      child: period.id == selectedPeriodId
          ? _SelectedCell(label: period.label)
          : _UnselectedCell(label: period.label),
    );
  }
}

class _SelectedCell extends StatelessWidget {
  final String label;
  const _SelectedCell({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppShadows.container,
      ),
      child: Center(
        child: Text(
          label,
          style: context.typography.label.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}

class _UnselectedCell extends StatelessWidget {
  final String label;
  const _UnselectedCell({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      color: AppColors.transparent,
      child: Center(
        child: Text(
          label,
          style: context.typography.label.copyWith(color: AppColors.teal),
        ),
      ),
    );
  }
}

class Period {
  final PeriodId id;
  final String label;

  Period({required this.id, required this.label});
}

final List<Period> defaultPeriods = [
  Period(id: PeriodId.ONE_WEEK, label: "1W"),
  Period(id: PeriodId.ONE_MONTH, label: "1M"),
  Period(id: PeriodId.THREE_MONTH, label: "3M"),
  Period(id: PeriodId.SIX_MONTH, label: "6M"),
  Period(id: PeriodId.YTD, label: "YTD"),
  Period(id: PeriodId.ONE_YEAR, label: "1Y"),
  Period(id: PeriodId.ALL, label: "ALL"),
];

enum PeriodId {
  ONE_WEEK,
  ONE_MONTH,
  THREE_MONTH,
  SIX_MONTH,
  YTD,
  ONE_YEAR,
  ALL
}
