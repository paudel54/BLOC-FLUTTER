import 'package:bloc/bloc.dart';
import '../data/transactions.dart';
import 'package:equatable/equatable.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc()
      : super(
          const TransactionState(
            totalIncome: 0,
            totalExpense: 0,
            netBalance: 0,
          ),
        ) {
    on<AppStarted>(_onStarted);
    on<AddTransaction>(_onAddTransaction);
    on<RemoveTransaction>(_onRemoveTransaction);
    on<UpdateTransaction>(_onUpdateTransaction);
    on<ToggleSwitch>(_onToggleSwitch);
    on<CalculateTransaction>(_onCalculateTransactions);
  }

  void _onStarted(AppStarted event, Emitter<TransactionState> emit) {
    print('hello from on started, want to computer the list values');
    if (state.status == TransactionStatus.success) return;
    // final totalExpense = state.transactions.fold(
    //   0.0,
    //   (sum, transaction) =>
    //       sum + (transaction.isIncome ? 0 : transaction.value),
    // );
    // final totalIncome = state.transactions.fold(
    //     0.0,
    //     (sum, transaction) =>
    //         sum + (transaction.isIncome ? transaction.value : 0));
    // final netBalance = totalExpense - totalIncome;
    // emit(state.copyWith(
    //   transactions: state.transactions,
    //   status: TransactionStatus.success,
    //   totalExpense: totalExpense,
    //   totalIncome: totalIncome,
    //   netBalance: netBalance,
    // ));
    emit(state.copyWith(
        transactions: state.transactions, status: TransactionStatus.success));
  }

  void _onCalculateTransactions(
      CalculateTransaction event, Emitter<TransactionState> emit) {
    print(state.transactions);
    final totalExpense = state.transactions.fold<double>(
      0.0,
      (sum, transaction) =>
          sum + (transaction.isIncome ? 0 : transaction.value),
    );
    final totalIncome = state.transactions.fold<double>(
      0.0,
      (sum, transaction) =>
          sum + (transaction.isIncome ? transaction.value : 0),
    );
    final netBalance = totalIncome - totalExpense;
    final updatedTransactions = List<Transaction>.from(state.transactions);
    emit(state.copyWith(
      transactions: updatedTransactions,
      status: TransactionStatus.success,
      totalExpense: totalExpense,
      totalIncome: totalIncome,
      netBalance: netBalance,
    ));
  }

  void _onAddTransaction(AddTransaction event, Emitter<TransactionState> emit) {
    print('I am trying to make new  transaction*********************');
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      List<Transaction> temp = [];
      temp.addAll(state.transactions);
      temp.insert(0, event.transaction);
      emit(
        state.copyWith(transactions: temp, status: TransactionStatus.success),
      );
    } catch (e) {
      emit(state.copyWith(status: TransactionStatus.error));
    }
  }

  void _onRemoveTransaction(
      RemoveTransaction event, Emitter<TransactionState> emit) {
    print('I am trying to remove the transaction*********************');
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      state.transactions.remove(event.transaction);
      emit(state.copyWith(
          transactions: state.transactions, status: TransactionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TransactionStatus.error));
    }
  }

  void _onUpdateTransaction(
      UpdateTransaction event, Emitter<TransactionState> emit) {}

  void _onToggleSwitch(ToggleSwitch event, Emitter<TransactionState> emit) {
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }
}
