import 'package:atodo/src/features/home/data/models/todo_model.dart';
import 'package:atodo/src/features/home/data/repository/todo_repository.dart';
import 'package:atodo/src/features/home/data/repository/todo_service.dart';

class ToDoRepositoryImpl implements ToDoRepository {
  ToDoService service = ToDoService();

  @override
  Future<List<Todo>> fetchTodo() async {
    return await service.fetchTodo();
  }

  @override
  Future<void> addTodo(Todo newToDo) async {
    return await service.addTodo(newToDo);
  }

  @override
  Future<void> removeTodo(String id) async {
    return await service.removeTodo(id);
  }

  @override
  Future<void> updateTodo(String id, String newStatus) async {
    return await service.updateTodo(id, newStatus);
  }
}
