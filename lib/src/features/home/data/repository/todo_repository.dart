import 'package:atodo/src/features/home/data/models/todo_model.dart';

abstract class ToDoRepository {
  Future<List<Todo>> fetchTodo();

  Future<void> addTodo(Todo newToDo);

  Future<void> removeTodo(String id);

  Future<void> updateTodo(String id, String newStatus);
}
