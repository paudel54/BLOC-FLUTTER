import 'package:bloc/bloc.dart';
import '../data/transactions.dart';
import 'package:equatable/equatable.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(const TransactionState()) {
    on<AppStarted>(_onStarted);
    on<AddTransaction>(_onAddTransaction);
    on<RemoveTransaction>(_onRemoveTransaction);
    on<UpdateTransaction>(_onUpdateTransaction);
    on<ToggleSwitch>(_onToggleSwitch);
  }

  void _onStarted(TransactionEvent event, Emitter<TransactionState> emit) {
    if (state.status == TransactionStatus.success) return;
    emit(state.copyWith(
        transactions: state.transactions, status: TransactionStatus.success));
  }

  void _onAddTransaction(AddTransaction event, Emitter<TransactionState> emit) {
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
