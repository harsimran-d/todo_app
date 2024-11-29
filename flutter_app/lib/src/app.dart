import 'package:flutter/material.dart';

import 'features/todos/todos_list_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TodosListScreen());
  }
}
