class Todo {
  final int id;
  String title;
  bool isCompleted;

  Todo(this.id, this.title, {this.isCompleted = false});
  String get getTitle {
    return this.title;
  }

  void setTitle(String title) {
    this.title = title;
  }

  int get getId {
    return this.id;
  }

  bool get getIsCompleted {
    return this.isCompleted;
  }

  void setStatus(bool status) {
    this.isCompleted = status;
  }

  static Map<String, dynamic> toMap(Todo todo) {
    return {
      "todoId": todo.getId,
      "title": todo.getTitle,
      "isCompleted": (todo.getIsCompleted == true) ? 1 : 0,
    };
  }

}
