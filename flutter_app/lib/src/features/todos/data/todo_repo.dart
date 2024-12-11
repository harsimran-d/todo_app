import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/src/features/todos/domain/todo.dart';

class TodoRepo {
  TodoRepo({required this.url});
  final String url;

  Future<Todo> createTodo({required String title}) async {
    final response = await http.post(Uri.parse("$url/todo"),
        body: jsonEncode({"id": 0, "title": title, "status": false}));

    if (response.statusCode != 201) {
      throw Exception("Something went wrong");
    } else {
      return Todo.fromJson(jsonDecode(response.body));
    }
  }

  Future<List<Todo>> fetchAllTodos() async {
    final response = await http.get(Uri.parse("$url/todo"));

    if (response.statusCode != 200) {
      throw Exception("Something went wrong");
    } else {
      // Parse a list of json objects
      final rawList = jsonDecode(response.body) as List<dynamic>;
      return rawList.map((rawTodo) {
        return Todo.fromJson(rawTodo);
      }).toList();
    }
  }
}
