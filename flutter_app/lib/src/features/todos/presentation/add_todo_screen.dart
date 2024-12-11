import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todos/application/bloc/todos_bloc.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Title cannot be empty";
                      }
                      return null;
                    },
                    controller: _titleController,
                  ),
                ),
              ),
              BlocConsumer<TodosBloc, TodosState>(
                listener: (context, state) {
                  Navigator.of(context).pop();
                },
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<TodosBloc>()
                              .add(TodoCreated(_titleController.value.text));
                        }
                      },
                      child: const Text("Create Todo"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
