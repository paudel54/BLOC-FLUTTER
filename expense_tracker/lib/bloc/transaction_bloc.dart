// import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../data/transactions.dart';
import 'package:equatable/equatable.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends HydratedBloc<TransactionEvent, TransactionState> {
  TransactionBloc()
      : super(
          const TransactionState(),
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
    emit(
      state.copyWith(
          transactions: state.transactions,
          status: TransactionStatus.success,
          totalIncome: state.totalIncome,
          totalExpense: state.totalExpense,
          netBalance: state.netBalance),
    );
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
      UpdateTransaction event, Emitter<TransactionState> emit) {
    // final int index = state.transactions.indexWhere(
    //   (transaction) => transaction.id == event.updatedTransaction.id,);
    final int index = event.index;

    print('chking th value of index received from the event ${index}');
    if (index != -1) {
      try {
        final List<Transaction> updatedTransactions =
            List.from(state.transactions);
        updatedTransactions[index] = event.updatedTransaction;

        // Emit a state with the updated list and recalculated values
        emit(
          TransactionsUpdated(updatedTransactions),
        );

        _onCalculateTransactions(
            CalculateTransaction(), emit); // Recalculate totals
      } catch (error) {
        emit(TransactionUpdateFailed(error));
      }
    } else {
      // Handle transaction not found scenario (optional)
      emit(TransactionUpdateFailed(
        'Transaction with ID ${event.updatedTransaction.id} not found',
      ));
    }
  }

  void _onToggleSwitch(ToggleSwitch event, Emitter<TransactionState> emit) {
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }

  @override
  TransactionState? fromJson(Map<String, dynamic> json) {
    print('1. fromJSON Hydrated ******${json}');
    return TransactionState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TransactionState state) {
    print('4 toJson Hydrated Bloc ******* ${state}');
    return state.toJson();
  }
}
