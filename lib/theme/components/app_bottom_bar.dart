import 'package:collection/collection.dart';
import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:finvest_credit_card_account/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  final _items = [
    AppBottomBarItem(label: "Home", assetPath: "assets/ic_home.svg"),
    AppBottomBarItem(label: "Invest", assetPath: "assets/ic_invest.svg"),
    AppBottomBarItem(label: "Discover", assetPath: "assets/ic_discovery.svg"),
    AppBottomBarItem(label: "Account", assetPath: "assets/image_accounts.png")
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double itemWidth =
        (MediaQuery.of(context).size.width) / _items.length;
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        color: AppColors.grey,
        border: Border(top: BorderSide(color: AppColors.white, width: 1)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.ease,
                  width: itemWidth * selectedIndex,
                  height: 3,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.ease,
                  width: itemWidth - 40,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(100),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: _items.mapIndexed((index, item) {
                  return Flexible(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Center(
                        child: _AppBottomBarItemWidget(
                          isSelected: index == selectedIndex,
                          appBottomBarItem: item,
                        ),
                      ),
                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}

class _AppBottomBarItemWidget extends StatelessWidget {
  final bool isSelected;
  final AppBottomBarItem appBottomBarItem;

  const _AppBottomBarItemWidget({
    super.key,
    required this.isSelected,
    required this.appBottomBarItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (isSvg(appBottomBarItem.assetPath))
          SvgPicture.asset(
            appBottomBarItem.assetPath,
            height: 30,
            width: 30,
            colorFilter: isSelected
                ? const ColorFilter.mode(AppColors.blue, BlendMode.srcIn)
                : const ColorFilter.mode(AppColors.teal, BlendMode.srcIn),
          )
        else
          Image.asset(
            appBottomBarItem.assetPath,
            width: 30,
            height: 30,
          ),
        Text(
          appBottomBarItem.label.toUpperCase(),
          style: context.typography.label.copyWith(
            fontSize: 10,
            color: isSelected ? AppColors.blue : AppColors.teal,
          ),
        ),
      ],
    );
  }

  bool isSvg(String assetPath) {
    return assetPath.toLowerCase().endsWith('.svg');
  }
}

class AppBottomBarItem {
  final String label;
  final String assetPath;

  AppBottomBarItem({required this.label, required this.assetPath});
}
