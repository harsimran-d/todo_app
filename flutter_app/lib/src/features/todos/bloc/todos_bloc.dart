import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/models/models.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService service;
  TodosBloc(this.service) : super(TodosState(todos: [])) {
    on<FetchAll>(_fetchAllTodos);
    on<TodoCreated>(_todoCreated);
    on<TodoUpdated>(_todoUpdated);
    on<TodoDeleted>(_todoDeleted);
  }

  void _fetchAllTodos(FetchAll event, Emitter<TodosState> emit) {}
  void _todoCreated(TodoCreated event, Emitter<TodosState> emit) {}
  void _todoUpdated(TodoUpdated event, Emitter<TodosState> emit) {}
  void _todoDeleted(TodoDeleted event, Emitter<TodosState> emit) {}
}
