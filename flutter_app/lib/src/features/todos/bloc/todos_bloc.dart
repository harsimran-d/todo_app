import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/models/models.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService service;
  TodosBloc(this.service)
      : super(TodosState(
            todos: [Todo(id: 1, title: "Demo Todo", status: false)])) {
    on<FetchAll>(_fetchAllTodos);
    on<TodoCreated>(_todoCreated);
    on<TodoUpdated>(_todoUpdated);
    on<TodoDeleted>(_todoDeleted);
  }

  void _fetchAllTodos(FetchAll event, Emitter<TodosState> emit) {}
  void _todoCreated(TodoCreated event, Emitter<TodosState> emit) {
    final newTodo =
        Todo(id: state.todos.length + 1, title: event.newTodo, status: false);
    emit(state.copyWith([...state.todos, newTodo]));
  }

  void _todoUpdated(TodoUpdated event, Emitter<TodosState> emit) {
    final List<Todo> newTodos = [];
    for (final todo in state.todos) {
      if (todo.id == event.todo.id) {
        newTodos.add(event.todo);
      } else {
        newTodos.add(todo);
      }
    }
    emit(state.copyWith(newTodos));
  }

  void _todoDeleted(TodoDeleted event, Emitter<TodosState> emit) {
    final List<Todo> newTodos = [];
    for (final todo in state.todos) {
      if (todo.id == event.todo.id) {
        continue;
      } else {
        newTodos.add(todo);
      }
    }
    emit(state.copyWith(newTodos));
  }
}
