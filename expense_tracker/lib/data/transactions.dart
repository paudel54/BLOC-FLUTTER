import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Transaction extends Equatable {
  final double value; // Amount
  final bool isIncome; // Switch income or expense
  final String remark; // Additional information for the transaction
  final DateTime date; // Date and time of the transaction
  final String id;

  Transaction({
    required this.value,
    this.isIncome = false,
    required this.remark,
    required this.date,
  }) : id = const Uuid().v1();

  Transaction copyWith({
    double? value,
    bool? isIncome,
    String? remark,
    DateTime? date,
  }) {
    return Transaction(
      value: value ?? this.value,
      isIncome: isIncome ?? this.isIncome,
      remark: remark ?? this.remark,
      date: date ?? this.date,
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      value: json['value'] as double,
      isIncome: json['isIncome'] as bool,
      remark: json['remark'] as String,
      date: DateTime.parse(json['date'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'isIncome': isIncome,
      'remark': remark,
      'date': date.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Transaction{uuid: $id, value: $value, isIncome: $isIncome, remark: $remark, date: $date}';
  }

  @override
  List<Object?> get props => [id, value, isIncome, remark, date];
}
