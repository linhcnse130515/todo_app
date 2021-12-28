import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manabie_todo_app/repositories/i_todos_repository.dart';
import 'package:manabie_todo_app/repositories/todos_repository.dart';

final todosRepositoryProvider = Provider<ITodoRepository>((ref) {
  return TodoRepository();
});
