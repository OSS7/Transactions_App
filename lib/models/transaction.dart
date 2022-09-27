import 'dart:convert';

class LocalTransaction {
  final int? id;
  final int? categoryId;
  final String? categoryName;
  final String? amount;
  final String? description;
  DateTime? transactionDate;

  LocalTransaction({
    this.id,
    this.categoryId,
    this.categoryName,
    this.amount,
    this.description,
    this.transactionDate,
  });

  factory LocalTransaction.fromJson(Map<String, dynamic> json) {
    return LocalTransaction(
        id: json['id'],
        categoryId: json['category_id'],
        categoryName: json['category_name'],
        amount: json['amount'],
        description: json['description'],
        transactionDate: DateTime.parse(json['transaction_date']));
  }

  static Map<String, dynamic>? toMap(LocalTransaction transaction) => {
        'id': transaction.id,
        'category_id': transaction.categoryId,
        'category_name': transaction.categoryName,
        'amount': transaction.amount,
        'description': transaction.description,
        'transaction_date': transaction.transactionDate,
      };

  static String encode(List<LocalTransaction> transactions) => json.encode(
        transactions
            .map<Map<String, dynamic>?>(
                (transaction) => LocalTransaction.toMap(transaction))
            .toList(),
      );

  static List<LocalTransaction> decode(String transaction) =>
      (json.decode(transaction) as List<dynamic>)
          .map<LocalTransaction>((item) => LocalTransaction.fromJson(item))
          .toList();
}
