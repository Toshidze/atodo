import 'package:atodo/src/core/settings/add_todo_helper.dart';
import 'package:flutter/material.dart';

class ShowTodoDialog extends StatefulWidget {
  const ShowTodoDialog({Key? key}) : super(key: key);

  @override
  State<ShowTodoDialog> createState() => _ShowTodoDialogState();
}

class _ShowTodoDialogState extends State<ShowTodoDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  List todos = List.empty();
  String title = '';
  String description = '';
  String status = '';
  final _todoHelper = AddTodoHelper();
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.purple,
      onPressed: () async {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: const Text('Новая задача'),
                content: SizedBox(
                  width: 400,
                  height: 100,
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        onChanged: (String value) {
                          title = value;
                        },
                      ),
                      TextField(
                        controller: descriptionController,
                        onChanged: (String value) {
                          description = value;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        setState(() {
                          if (titleController.text.isNotEmpty &&
                              descriptionController.text.isNotEmpty &&
                              titleController.text != null &&
                              descriptionController.text != null) {
                            _todoHelper.addTodo(
                                context, titleController, descriptionController,
                                statusTodo: 'new');
                          }
                        });
                        titleController.clear();
                        descriptionController.clear();

                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'))
                ],
              );
            });
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
