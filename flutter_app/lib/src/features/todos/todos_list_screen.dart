import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todos/bloc/todos_bloc.dart';

import '../add_todo/add_todo_screen.dart';

class TodosListScreen extends StatelessWidget {
  const TodosListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 600,
            child: BlocBuilder<TodosBloc, TodosState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) => ListView.separated(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  final todo = state.todos[index];
                  return Dismissible(
                    key: Key(todo.id.toString()),
                    onDismissed: (_) {
                      context.read<TodosBloc>().add(TodoDeleted(todo));
                    },
                    child: ListTile(
                      leading: Text(todo.id.toString()),
                      title: Text(todo.title),
                      trailing: Checkbox(
                          value: todo.status,
                          onChanged: (val) {
                            if (val != null) {
                              context
                                  .read<TodosBloc>()
                                  .add(TodoUpdated(todo.copyWith(status: val)));
                            }
                          }),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => const AddTodoScreen(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
