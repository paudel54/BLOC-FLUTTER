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
    this.totalIncome = 0.0,
    this.totalExpense = 0.0,
    this.netBalance = 0.0,
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

  @override
  factory TransactionState.fromJson(Map<String, dynamic> json) {
    try {
      print('2. fromJSON State *****check null values ${json}');
      var listOfTransactions = (json['transactions'] as List<dynamic>)
          .map((item) => Transaction.fromJson(item))
          .toList();
      return TransactionState(
        transactions: listOfTransactions,
        status: TransactionStatus.values
            .firstWhere((e) => e.toString() == json['status']),
        isSwitch: json['isSwitch'],
        totalExpense: json['totalExpense'],
        totalIncome: json['totalIncome'],
        netBalance: json['netBalance'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    print('5. toJSON State ****');
    return {
      'status': status.name,
      // suggestion
      'transactions':
          transactions.map((transaction) => transaction.toJson()).toList(),
      'isSwitch': isSwitch,
      'totalExpense': totalExpense,
      'totalIncome': totalIncome,
      'netBalance': netBalance,
    };
  }

  @override
  List<Object?> get props =>
      [transactions, status, isSwitch, totalExpense, totalIncome, netBalance];
}

// ... other states
class TransactionInitial extends TransactionState {}

class TransactionsUpdated extends TransactionState {
  final List<Transaction> transactions;

  const TransactionsUpdated(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TransactionUpdateFailed extends TransactionState {
  final Object error;

  const TransactionUpdateFailed(this.error);

  @override
  List<Object> get props => [error];
}
