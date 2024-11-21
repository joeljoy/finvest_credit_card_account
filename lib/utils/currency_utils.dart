import 'package:intl/intl.dart';

class CurrencyUtils {
  static (String, String) getFormattedAmount(
      {required num amount, Currency currency = Currency.DOLLARS}) {
    final formatter = CurrencyFormatterManager.getFormatter(currency);
    final formattedAmount = formatter.format(amount);
    List<String> parts = formattedAmount.split('.');
    String integral = parts[0];
    String decimal = parts.length > 1 ? '.${parts[1]}' : '.00';
    return (integral, decimal);
  }
}

enum Currency {
  // ignore: constant_identifier_names
  DOLLARS,
}

abstract class CurrencyFormatter {
  String format(num amount);
}

class DollarCurrencyFormatter implements CurrencyFormatter {
  @override
  String format(num amount) {
    final format = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return format.format(amount);
  }
}

class CurrencyFormatterManager {
  static final Map<Currency, CurrencyFormatter> formatterMap = {
    Currency.DOLLARS: DollarCurrencyFormatter(),
  };

  static CurrencyFormatter getFormatter(Currency currency) {
    if (formatterMap.containsKey(currency)) {
      return formatterMap[currency]!;
    } else {
      throw "Cannot find formatter for currency: ${currency.name}";
    }
  }
}
