// ignore_for_file: constant_identifier_names

class Transaction {
  final double value;
  final int date;
  final String merchantName;
  final String categoryId;
  final String creditCardId;
  final TransactionStatus status;
  final TransactionType type;

  Transaction({
    required this.value,
    required this.date,
    required this.merchantName,
    required this.categoryId,
    required this.creditCardId,
    required this.status,
    required this.type,
  });
}

enum TransactionStatus {
  COMPLETED,
  PENDING,
}

extension TransactionStatusExt on TransactionStatus {
  String get label {
    switch (this) {
      case TransactionStatus.COMPLETED:
        return "Completed";
      case TransactionStatus.PENDING:
        return "Pending";
    }
  }
}

enum TransactionType {
  BUY,
  SELL,
  DEPOSIT,
  WITHDRAWL,
}

extension TransactionTypeExt on TransactionType {
  String get label {
    switch (this) {
      case TransactionType.BUY:
        return "Buy";
      case TransactionType.SELL:
        return "Sell";
      case TransactionType.DEPOSIT:
        return "Deposit";
      case TransactionType.WITHDRAWL:
        return "Withdrawal";
    }
  }
}
