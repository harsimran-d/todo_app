import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/todo.dart';
import '../todo_service.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService service;
  TodosBloc(this.service) : super(TodosState(todos: [])) {
    on<FetchAll>(_fetchAllTodos);
    on<TodoCreated>(_todoCreated);
    on<TodoUpdated>(_todoUpdated);
    on<TodoDeleted>(_todoDeleted);

    add(FetchAll());
  }

  Future<void> _fetchAllTodos(FetchAll event, Emitter<TodosState> emit) async {
    try {
      final todos = await service.fetchAllTodos();
      emit(TodosState(todos: todos));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _todoCreated(TodoCreated event, Emitter<TodosState> emit) async {
    try {
      final newTodo = await service.createTodo(
        title: event.newTodo,
      );
      emit(state.copyWith([...state.todos, newTodo]));
    } catch (e) {
      print(e);
    }
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
