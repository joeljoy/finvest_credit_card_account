import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/components/app_slider/app_slider_thumb.dart';
import 'package:flutter/material.dart';

class AppSlider extends StatefulWidget {
  final double min;
  final double max;
  const AppSlider({super.key, required this.min, required this.max});

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  double _start = 0.0;
  double _end = 0.0;

  @override
  void initState() {
    _start = widget.min;
    _end = widget.max;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: AppColors.teal,
        inactiveTrackColor: AppColors.grey2,
        trackHeight: 0.1,
        rangeThumbShape: AppSliderThumb(thumbRadius: 16),
      ),
      child: RangeSlider(
          min: widget.min,
          max: widget.max,
          values: RangeValues(_start, _end),
          onChanged: (values) {
            setState(() {
              _start = values.start;
              _end = values.end;
            });
          }),
    );
  }
}
