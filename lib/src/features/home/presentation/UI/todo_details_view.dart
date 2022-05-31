import 'package:atodo/src/core/settings/add_todo_helper.dart';
import 'package:atodo/src/features/home/presentation/bloc/todo_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoDetailsView extends StatefulWidget {
  const TodoDetailsView({
    Key? key,
    required this.title,
    required this.description,
    required this.status,
    required this.snapshot,
  }) : super(key: key);

  final String title;
  final String description;
  final String status;
  final QueryDocumentSnapshot<Object?>? snapshot;

  @override
  State<TodoDetailsView> createState() => _TodoDetailsViewState();
}

class _TodoDetailsViewState extends State<TodoDetailsView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  final _todoHelper = AddTodoHelper();

  @override
  Widget build(BuildContext context) {
    var blocProvider = context.read<TodoBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Описание задачи'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Заголовок",
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Заголовок",
                border: OutlineInputBorder(),
              ),
              maxLines: 10,
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          ElevatedButton(
              onPressed: (() {
                Navigator.pop(context);
                blocProvider
                    .add(UpdateTodo('inProgress', id: widget.snapshot!.id));
                _todoHelper.addTodo(
                    context, titleController, descriptionController,
                    statusTodo: widget.status);
              }),
              child: const Text('Сохранить'))
        ],
      ),
    );
  }
}
