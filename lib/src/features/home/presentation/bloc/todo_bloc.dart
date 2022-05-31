import 'package:atodo/src/features/home/data/models/todo_model.dart';
import 'package:atodo/src/features/home/data/repository/todo_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ToDoRepositoryImpl todoRepository;
  TodoBloc({
    required this.todoRepository,
  }) : super(TodosLoading()) {
    on<LoadTodo>((event, emit) async {
      List<Todo> _todosLoaded = [];
      try {
        _todosLoaded = await todoRepository.fetchTodo();
      } catch (e) {
        rethrow;
      }
      _todosLoaded;

      return emit(TodoState(todos: _todosLoaded));
    });
    on<AddTodo>((event, emit) async {
      var newList = state.todos;
      try {
        event.todos.setId(TimeOfDay.now().toString());
        newList = [event.todos, ...newList];
      } catch (e) {
        rethrow;
      }
      return emit(TodoState(todos: newList));
    });
    on<DeleteTodo>((event, emit) async {
      await todoRepository.removeTodo(event.id);
    });
    on<UpdateTodo>((event, emit) async {
      await todoRepository.updateTodo(event.id, event.status);
    });
  }
}
