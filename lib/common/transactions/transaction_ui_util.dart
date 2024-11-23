import 'package:finvest_credit_card_account/common/transactions/domain/entities/transaction.dart';
import 'package:finvest_credit_card_account/utils/data_and_time_util.dart';

class TransactionUiUtil {
  static String composeDescription(Transaction transaction) {
    final formattedDate = DataAndTimeUtil.formatDate(transaction.date);
    final description = StringBuffer(formattedDate);
    if (transaction.status == TransactionStatus.PENDING) {
      description.write(' • Pending');
    }
    return description.toString();
  }
}

extension TransactionExt on Transaction {
  String get description {
    return TransactionUiUtil.composeDescription(this);
  }
}
