import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  String? id;
  String? todoTitle;
  String? todoDesc;
  String? status;
  String? date;
  String? time;

  Todo({
    this.id,
    this.todoTitle,
    this.todoDesc,
    this.status,
    this.date,
  });

  Todo copyWith({
    String? id,
    String? todoTitle,
    String? todoDesc,
    String? status,
    String? date,
  }) {
    return Todo(
      id: id ?? this.id,
      todoTitle: todoTitle ?? this.todoTitle,
      todoDesc: todoDesc ?? this.todoDesc,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }

  factory Todo.fromSnapshot(Map<String, dynamic> snap) => Todo(
        id: snap['id'] ?? '',
        todoTitle: snap['todoTitle'] ?? '',
        todoDesc: snap['todoDesc'] ?? '',
        status: snap['status'] ?? '',
        date: snap['date'] ?? '',
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todoTitle': todoTitle,
      'todoDesc': todoDesc,
      'status': status,
      'date': date,
    };
  }

  void setId(String id) {
    this.id = id;
  }

  @override
  String toString() {
    return "Todo{ id:$id,todoTitle:$todoTitle,todoDesc:$todoDesc,}";
  }

  @override
  List<Object?> get props => [
        id,
        todoTitle,
        todoDesc,
        status,
        date,
      ];
}
