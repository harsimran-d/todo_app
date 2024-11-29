part of 'todos_bloc.dart';

final class TodosState {
  final List<Todo> todos;
  TodosState({required this.todos});

  TodosState copyWith(List<Todo>? todos) {
    return TodosState(todos: todos ?? this.todos);
  }
}
