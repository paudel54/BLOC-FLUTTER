class Transaction {
  final int id; // for filtering and db operation
  final double value; // Amount
  final bool isIncome; // Switch income or expense
  final String remark; // Additional information for the transaction
  final DateTime date; // Date and time of the transaction

  Transaction(
      {this.id = 1,
      required this.value,
      required this.isIncome,
      required this.remark,
      required this.date});

  Transaction copyWith(
      {int? id,
      double? value,
      bool? isIncome,
      String? remark,
      DateTime? date}) {
    return Transaction(
      id: id ?? this.id,
      value: value ?? this.value,
      isIncome: isIncome ?? this.isIncome,
      remark: remark ?? this.remark,
      date: date ?? this.date,
    );
  }

  // For persisting data with file system. Serializing and deSerializing.
  // Deserialize JSON to Transaction object
  factory Transaction.fromJson(Map<String, dynamic> json) {
    print('3. fromJSON Data layer *********${json}');
    return Transaction(
      id: json['id'] as int,
      value: json['value'] as double,
      isIncome: json['isIncome'] as bool,
      remark: json['remark'] as String,
      // as String modified to toString
      date: DateTime.parse(json['date'].toString()),
    );
  }
  // Serialize Transaction object to JSON to save with file sys.
  Map<String, dynamic> toJson() {
    print('6. toJSON data Layer');
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
