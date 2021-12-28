import 'package:flutter/cupertino.dart';
import 'package:manabie_todo_app/models/todo.dart';
import 'package:manabie_todo_app/repositories/i_todos_repository.dart';

class AppData extends ChangeNotifier {
  ITodoRepository todoRepository;
  List<Todo> all =[];
  int autoId = 0;

  void setRepos(ITodoRepository todoRep) {
    this.todoRepository = todoRep;
  }

  Future<void> getTodos() async {
    all = await todoRepository.getTodos();
    notifyListeners();
  }

  void createTodo(String title) {
    int todoIndex = all.indexWhere((element) => element.id == autoId);
    while (todoIndex != -1) {
      ++autoId;
      todoIndex = all.indexWhere((element) => element.id == autoId);
    }
    final todo = Todo(++autoId, title);
    all.add(todo);
    todoRepository.insertTodo(todo);
    notifyListeners();
  }

  void deleteTodo(int id) {
    for (int i = 0; i < all.length; i++) {
      if (all[i].getId == id) {
        all.removeAt(i);
        break;
      }
    }

    todoRepository.deleteTodo(id);
    notifyListeners();
  }

  void updateTodo(int id, {bool isCompleted}) {
    int todoIndex = all.indexWhere((element) => element.id == id);

    Todo todo = all.elementAt(todoIndex);
    todo.setStatus(isCompleted);

    todoRepository.updateTodo(todo);
    notifyListeners();
  }
}
