part of 'transaction_bloc.dart';

enum TransactionStatus { initial, loading, success, error }

class TransactionState extends Equatable {
  final List<Transaction> transactions;
  final TransactionStatus status;

// constructor
  const TransactionState(
      {this.transactions = const <Transaction>[],
      this.status = TransactionStatus.initial});

  TransactionState copyWith({
    TransactionStatus? status,
    List<Transaction>? transactions,
  }) {
    return TransactionState(
        transactions: transactions ?? this.transactions,
        status: status ?? this.status);
  }

  Map<String, dynamic> toJson() {
    return {
      'transactions': transactions,
      'status': status.name,
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
  List<Object?> get props => [transactions, status];
}
