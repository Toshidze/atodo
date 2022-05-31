import 'package:atodo/src/features/home/data/models/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoService {
  var todoList = FirebaseFirestore.instance.collection("atodo");

  Future<List<Todo>> fetchTodo() async {
    var data = await todoList.get();
    var todos = data.docs
        .map((snapshot) => Todo.fromSnapshot(snapshot.data()))
        .toList();
    return todos;
  }

  Future<void> addTodo(Todo newTodo) async {
    return await todoList.doc(newTodo.todoTitle).set(newTodo.toMap());
  }

  Future<void> removeTodo(String id) async {
    await todoList.doc(id).delete();
  }

  updateTodo(String id, String newStatus) {
    todoList.doc(id).update({'status': newStatus});
  }
}
