part of 'todos_bloc.dart';

sealed class TodosEvent {}

final class FetchAll extends TodosEvent {}

final class TodoCreated extends TodosEvent {
  final Todo newTodo;
  TodoCreated(this.newTodo);
}

final class TodoUpdated extends TodosEvent {
  final Todo todo;
  TodoUpdated(this.todo);
}

final class TodoDeleted extends TodosEvent {
  final Todo todo;
  TodoDeleted(this.todo);
}
