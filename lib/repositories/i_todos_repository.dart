import 'package:manabie_todo_app/models/todo.dart';

abstract class ITodoRepository {
  Future<List<Todo>> getTodos();

  Future<void> updateTodo(Todo todo);

  Future<void> insertTodo(Todo todo);

  Future<void> deleteTodo(int index);
}
