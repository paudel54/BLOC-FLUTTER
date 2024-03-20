part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, error }

class TodoState extends Equatable {
  // list of Todo objects representing todo items in list
  final List<Todo> todos;
  final TodoStatus status;

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

  @override
  factory TodoState.fromJson(Map<String, dynamic> json) {
    try {
      print('JSON before mapping: $json');
      print('2 from the from json in  the todo_state.dart');
      var listOfTodos = (json['todo'] as List<dynamic>)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
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
    print('5 i am from todo_state toJson function');
    return {'todo': todos, 'status': status.name};
  }

  @override
  List<Object?> get props => [todos, status];
}
