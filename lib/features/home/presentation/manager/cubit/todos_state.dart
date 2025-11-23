part of 'todos_cubit.dart';

sealed class TodosState {}

final class TodosInitial extends TodosState {}

final class TodosSuccess extends TodosState {
  final List<TodoModel> todos;

  TodosSuccess(this.todos);
}

final class TodosLoading extends TodosState {}

final class TodosFailure extends TodosState {
  final String message;

  TodosFailure(this.message);
}
