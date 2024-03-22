class Transaction {
  final int? id; // for filtering and db operation
  final double value; // Amount
  final bool isIncome; // Switch income or expense
  final String remark; // Additional information for the transaction
  final DateTime date; // Date and time of the transaction

  Transaction(
      {this.id,
      required this.value,
      required this.isIncome,
      required this.remark,
      required this.date});

  // For persisting data with file system. Serializing and deSerializing.
  // Deserialize JSON to Transaction object
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int,
      value: json['value'] as double,
      isIncome: json['isIncome'] as bool,
      remark: json['remark'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }
  // Serialize Transaction object to JSON to save with file sys.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'isIncome': isIncome,
      'remark': remark,
      'date': date.toIso8601String(),
    };
  }

// to make instance/Object of Transaction more human readable
  @override
  String toString() {
    return 'Transaction{id: $id, value: $value, isIncome: $isIncome, remark: $remark, date: $date}';
  }
}
