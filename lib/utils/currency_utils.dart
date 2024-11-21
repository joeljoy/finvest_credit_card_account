import 'package:intl/intl.dart';

class CurrencyUtils {
  /// Splits a formatted currency amount into integral and decimal parts.
  ///
  /// This method formats a given numeric amount based on the specified currency
  /// and returns the integral and decimal parts separately as a tuple.
  ///
  /// ### Parameters:
  /// - [amount]: The numeric amount to format. This is a required parameter.
  /// - [currency]: The currency type used for formatting. Defaults to `Currency.DOLLARS` if not specified.
  ///
  /// ### Returns:
  /// A record `(String integral, String decimal)`:
  /// - `integral`: The formatted integral part of the amount (e.g., "23,450").
  /// - `decimal`: The formatted decimal part of the amount (e.g., ".24"). If the amount
  ///   does not have a decimal portion, `.00` is used as the default.
  ///
  /// ### Notes:
  /// - This function relies on `CurrencyFormatterManager.getFormatter()` to
  ///   obtain the appropriate formatter for the specified currency.
  /// - Ensure `CurrencyFormatterManager` and the `Currency` enum are properly
  ///   defined in your codebase.
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
