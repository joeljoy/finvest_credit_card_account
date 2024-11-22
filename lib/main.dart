import 'package:finvest_credit_card_account/features/home/home_depenendecy.dart';
import 'package:finvest_credit_card_account/features/home/home_view.dart';
import 'package:finvest_credit_card_account/features/home/home_view_model.dart';
import 'package:finvest_credit_card_account/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HomeDepenendecy.inject();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  GetIt get serviceLocator => GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.regular();
    return MaterialApp(
      theme: ThemeData(extensions: [theme]),
      home: SafeArea(
        child: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(
            creditCardRepository: serviceLocator(),
            categoryRepository: serviceLocator(),
            transactionRepository: serviceLocator(),
          ),
          child: const HomeView(),
        ),
      ),
    );
  }
}
