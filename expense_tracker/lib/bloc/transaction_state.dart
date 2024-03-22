part of 'transaction_bloc.dart';

enum TransactionStatus { initial, loading, success, error }

class TransactionState extends Equatable {
  final List<Transaction> transactions;
  final TransactionStatus status;
  final bool isSwitch;
  final double totalExpense;
  final double totalIncome;
  final double netBalance;

// constructor
  const TransactionState({
    this.transactions = const <Transaction>[],
    this.status = TransactionStatus.initial,
    this.isSwitch = false,
    required this.totalExpense,
    required this.totalIncome,
    required this.netBalance,
  });

  TransactionState copyWith({
    TransactionStatus? status,
    List<Transaction>? transactions,
    bool? isSwitch,
    double? totalExpense,
    double? totalIncome,
    double? netBalance,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      status: status ?? this.status,
      isSwitch: isSwitch ?? this.isSwitch,
      totalExpense: totalExpense ?? this.totalExpense,
      totalIncome: totalIncome ?? this.totalIncome,
      netBalance: netBalance ?? this.netBalance,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactions': transactions,
      'status': status.name,
      'isSwitch': isSwitch,
    };
  }

  // factory TransactionState.fromJson(Map<String, dynamic> json) {
  //   return TransactionState(
  //     transactions: (json['transactions'] as List<dynamic>)
  //         .map((item) => Transaction.fromJson(item))
  //         .toList(),
  //     status: TransactionStatus.values
  //         .firstWhere((e) => e.toString() == json['status']),
  //   );
  // }

  @override
  List<Object?> get props =>
      [transactions, status, isSwitch, totalExpense, totalIncome, netBalance];
}
