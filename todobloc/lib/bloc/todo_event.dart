part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoStarted extends TodoEvent {}

class AddTodo extends TodoEvent {
  // constructor that takes Todo object as a parameter, indicating the todo item will be added.
  final Todo todo;
  const AddTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class RemoveTodo extends TodoEvent {
  final Todo todo;

  const RemoveTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

//alter todo checkmark, takes int paramenter in constructor to alter index of todo
class AlterTodo extends TodoEvent {
  final int index;
  const AlterTodo(this.index);

  @override
  List<Object> get props => [index];
}
