part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<Todo> todos;
  const TodoState({required this.todos});

  @override
  List<Object> get props => [todos];
}

class TodosLoading extends TodoState {
  TodosLoading() : super(todos: []);
}
