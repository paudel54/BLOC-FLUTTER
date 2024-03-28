part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, error }

class TodoState extends Equatable {
  // list of Todo objects representing todo items in list
  final List<Todo> todos;
  final TodoStatus status;

// when app gets installed for very first time this is initialized.
  const TodoState(
      {this.todos = const <Todo>[], this.status = TodoStatus.initial});

  TodoState copyWith({
    TodoStatus? status,
    List<Todo>? todos,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
    );
  }

// extracting and parsing
  @override
  factory TodoState.fromJson(Map<String, dynamic> json) {
    try {
      print('JSON before mapping to obj: $json');
      print('2 fromJson todo_state.dart');
      var listOfTodos = (json['todos'] as List<dynamic>)
          // from json is used from data class serialization
          .map((todoJson) => Todo.fromJson(todoJson as Map<String, dynamic>))
          .toList();
      print('List of todos after mapping: $listOfTodos');
      return TodoState(
          todos: listOfTodos,
          status: TodoStatus.values.firstWhere(
              (element) => element.name.toString() == json['status']));
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    print('5 toJson todo_state');

    return {
      // we are consuming the toJson model from date model or data.dart
      //creates list for JSON encoding [{"key":"v1"}]

      // here toJson method is used from data class. todo.dart
      'todos': todos.map((todo) => todo.toJson()).toList(),
      'status': status.name
    };
  }

  @override
  List<Object?> get props => [todos, status];
}
