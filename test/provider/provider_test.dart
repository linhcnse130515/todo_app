import 'package:flutter/cupertino.dart';
import 'package:manabie_todo_app/models/todo.dart';
import 'package:manabie_todo_app/providers/todos_repository_provider.dart';
import 'package:manabie_todo_app/providers/todos_state_notifier_provider.dart';
import 'package:manabie_todo_app/repositories/i_todos_repository.dart';
import 'package:test/test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group("Provider test todo", (){
    test("default is empty", () {
      final container = ProviderContainer();
      final value = container.read(todosStateNotifierProvider.state);
      expect(value, []);
    });

    test("add todo", () {
      final container = ProviderContainer(
        overrides: [
          todosRepositoryProvider
              .overrideWithProvider(Provider((ref) => MockTodosRepository()))
        ],
      );

      String title = "title";
      container.read(todosStateNotifierProvider).createTodo(title);
      debugPrint("title : " +
          container.read(todosStateNotifierProvider.state)[0].getTitle);
      debugPrint("id : " +
          container.read(todosStateNotifierProvider.state)[0].getId.toString());
      expect(container.read(todosStateNotifierProvider.state).length, 1);
      expect(container.read(todosStateNotifierProvider.state).first.getTitle,
          title);
    });
  });
}

class MockTodosRepository implements ITodoRepository {
  @override
  Future<void> deleteTodo(int index) {}

  @override
  Future<List<Todo>> getTodos() async {
    return [Todo(1, "title1")];
  }

  @override
  Future<void> insertTodo(Todo todo) {}

  @override
  Future<void> updateTodo(Todo todo) {}
}