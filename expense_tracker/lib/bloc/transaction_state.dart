part of 'transaction_bloc.dart';

enum TransactionStatus { initial, loading, success, error }

class TransactionState extends Equatable {
  final List<Transaction> transactions;
  final TransactionStatus status;
  final bool isSwitch;

// constructor
  const TransactionState({
    this.transactions = const <Transaction>[],
    this.status = TransactionStatus.initial,
    this.isSwitch = false,
  });

  TransactionState copyWith({
    TransactionStatus? status,
    List<Transaction>? transactions,
    bool? isSwitch,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      status: status ?? this.status,
      isSwitch: isSwitch ?? this.isSwitch,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactions': transactions,
      'status': status.name,
      'isSwitch': isSwitch,
    };
  }

  factory TransactionState.fromJson(Map<String, dynamic> json) {
    return TransactionState(
      transactions: (json['transactions'] as List<dynamic>)
          .map((item) => Transaction.fromJson(item))
          .toList(),
      status: TransactionStatus.values
          .firstWhere((e) => e.toString() == json['status']),
    );
  }

  @override
  List<Object?> get props => [transactions, status, isSwitch];
}
