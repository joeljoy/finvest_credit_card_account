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
  ALL,
  COMPLETED,
  PENDING,
}

enum TransactionType { ALL, BUY, SELL, DEPOSIT, WITHDRAWL }
