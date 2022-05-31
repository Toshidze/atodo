part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodo extends TodoEvent {
  const LoadTodo();

  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  final Todo todos;

  const AddTodo(
    this.todos,
  );
}

class UpdateTodo extends TodoEvent {
  final String status;
  final String id;

  const UpdateTodo(this.status, {required this.id});

  @override
  List<Object> get props => [
        status,
        id,
      ];
}

class DeleteTodo extends TodoEvent {
  final String id;

  const DeleteTodo({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
