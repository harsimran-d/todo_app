import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todos/application/bloc/todos_bloc.dart';
import 'package:todo_app/src/features/todos/data/todo_repo.dart';

import 'src/app.dart';
import 'src/features/todos/application/todo_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const String baseHref = "http://localhost:3000/api/v1";
  final repo = TodoRepo(url: baseHref);
  final service = TodoService(todoRepo: repo);
  runApp(BlocProvider(
    create: (_) => TodosBloc(service),
    child: const App(),
  ));
}
