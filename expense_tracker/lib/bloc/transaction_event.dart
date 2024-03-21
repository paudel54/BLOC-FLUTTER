part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
  @override
  List<Object> get props => [];
}

class AppStarted extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final Transaction transaction;
  const AddTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class RemoveTransaction extends TransactionEvent {
  final Transaction transaction;
  const RemoveTransaction(this.transaction);
  @override
  List<Object> get props => [transaction];
}

class UpdateTransaction extends TransactionEvent {}
