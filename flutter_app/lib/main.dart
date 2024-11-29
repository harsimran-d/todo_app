import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todos/bloc/todos_bloc.dart';

import 'src/app.dart';
import 'src/models/todo_service.dart';

void main() {
  final service = TodoService();
  runApp(BlocProvider(
    create: (_) => TodosBloc(service),
    child: const App(),
  ));
}
