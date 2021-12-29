import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manabie_todo_app/models/todo.dart';
import 'package:manabie_todo_app/repositories/i_todos_repository.dart';

class TodosStateNotifier extends StateNotifier<List<Todo>> {
  ITodoRepository todosRepository;
  List<Todo> completeList = [];

  TodosStateNotifier(this.todosRepository) : super([]);
  int autoIncrementId = 0;

  void createTodo(String title) {
    /*int todoIndex = state.indexWhere((element) => element.id == autoIncrementId);
    while (todoIndex != -1) {
      ++autoIncrementId;
      todoIndex = state.indexWhere((element) => element.id == autoIncrementId);
    }*/
    final todo = Todo(++autoIncrementId, title);
    state.add(todo);
    state = [...state];

    todosRepository.insertTodo(todo);
  }

  void deleteTodo(int id) {
    List<Todo> newList = [];
    for (int i = 0; i < state.length; i++) {
      if (state[i].getId != id) {
        newList.add(state[i]);
      }
    }
    state = newList;

    todosRepository.deleteTodo(id);
  }

  void updateTodo(int id, {String title, bool isCompleted}) {
    int todoIndex = state.indexWhere((element) => element.id == id);
    Todo todo = state.elementAt(todoIndex);
    todo.setStatus(isCompleted);
    state = [...state];

    todosRepository.updateTodo(todo);
  }

  Future<void> getTodos() async {
    state = await todosRepository.getTodos();
  }
}
