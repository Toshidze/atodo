import 'package:atodo/src/features/home/data/models/todo_model.dart';
import 'package:atodo/src/features/home/presentation/bloc/todo_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTodoHelper {
  final dateFormater = DateFormat('yyyy-MM-dd hh:mm');

  getDate() {
    var currentDate = DateTime.now();
    return currentDate;
  }

  final currentDate = DateTime.now();

  void addTodo(BuildContext context, TextEditingController titleController,
      TextEditingController descController,
      {String? statusTodo}) {
    final todoTitle = titleController.text;
    final todoDesc = descController.text;
    final status = statusTodo;
    final date = dateFormater.format(getDate.call());

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('atodo').doc(todoTitle);

    Map<String, String> todoList = {
      'todoTitle': todoTitle,
      'todoDesc': todoDesc,
      'status': status ?? 'new',
      'date': date.toString(),
    };

    documentReference
        .set(todoList)
        .whenComplete(() => print('Задача записана'));

    final todo = Todo(
      todoTitle: todoTitle,
      todoDesc: todoDesc,
      status: status,
      date: date.toString(),
    );

    context.read<TodoBloc>().add(AddTodo(todo));
  }
}
