import 'package:todo_app/src/features/todos/data/todo_repo.dart';
import 'package:todo_app/src/features/todos/domain/todo.dart';

class TodoService {
  TodoService({required this.todoRepo});
  final TodoRepo todoRepo;

  Future<List<Todo>> fetchAllTodos() async {
    final List<Todo> todos = await todoRepo.fetchAllTodos();
    return todos;
  }

  Future<Todo> createTodo({required String title}) async {
    final Todo todo = await todoRepo.createTodo(title: title);

    return todo;
  }
}
