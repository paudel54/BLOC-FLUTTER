import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../data/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<TodoStarted>(_onStarted);
    on<AddTodo>(_onAddTodo);
    on<RemoveTodo>(_onRemoveTodo);
    on<AlterTodo>(_onAlterTodo);
  }

  void _onStarted(TodoEvent event, Emitter<TodoState> emit) {
    // print(state);
    // print(state.status);
    // print(' on fresh install skip if block and emits status to success todoStarted');
    if (state.status == TodoStatus.success) return;
    // print('todo started success next line');
    emit(state.copyWith(todos: state.todos, status: TodoStatus.success));
  }

  void _onAddTodo(
    AddTodo event,
    Emitter<TodoState> emit,
  ) {
    // print('Checking the state ${state}');
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      List<Todo> temp = [];
      temp.addAll(state.todos);
      temp.insert(0, event.todo);
      emit(state.copyWith(todos: temp, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }

  void _onRemoveTodo(
    RemoveTodo event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      state.todos.remove(event.todo);
      emit(state.copyWith(todos: state.todos, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }

  void _onAlterTodo(
    AlterTodo event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      state.todos[event.index].isDone = !state.todos[event.index].isDone;
      emit(state.copyWith(todos: state.todos, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) {
    // print('printing state before converting to json on hydrated bloc');
    //{todo: [Instance of 'Todo', Instance of 'Todo'], status: success}
    // print(state.toJson());
    print('4 toJson Hydrated todo_bloc.dart');
    return state.toJson();
  }

// here fromJson is the feature of HydratedBloc not factory constructor of TodoState
  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    // print('printing the state to convert from json to map in hydrated bloc');
    //{todo: [{title: estt, subtitle: bbb, isDone: false}, {title: ram, subtitle: bhai, isDone: false}], status: success}
    // print(TodoState.fromJson(json)); => Converts into dart object
    //TodoState([Instance of 'Todo', Instance of 'Todo'], TodoStatus.success)
    print(json);
    print('1 fromJson Hydrated  todo_bloc.dart');
    return TodoState.fromJson(json);
  }
}
