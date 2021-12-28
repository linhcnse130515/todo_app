import 'package:flutter/material.dart';
import 'package:manabie_todo_app/models/todo.dart';
import 'package:manabie_todo_app/providers/app_data.dart';
import 'package:manabie_todo_app/repositories/todos_repository.dart';
import 'package:manabie_todo_app/widgets/TodoCard.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({Key key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  int _selectedItemIndex = 0;
  TextEditingController _titleController = TextEditingController();

  List<Todo> todos = [];
  void _changeWidget(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AppData>(context, listen: false).setRepos(TodoRepository());
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
    super.initState();
  }

  void _fetchData() {
    Provider.of<AppData>(context, listen: false).getTodos();
  }
  void _addTodo(String title) {
    Provider.of<AppData>(context, listen: false).createTodo(title);
    _titleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .accentColor,
        title: Center(child: Text("Todo App")),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(250, 50)),
                    child: TextFormField(
                      key: Key("title"),
                      controller: _titleController,
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme
                              .of(context)
                              .primaryColor),
                    ),
                    key: Key("addButton"),
                    onPressed: () => _addTodo(_titleController.text),
                    child: Icon(Icons.add)),
              ],
            ),
          ),
          todoList()
        ],
      ),
      bottomNavigationBar: _bottomNavigatorBar(context),
    );
  }

  Widget todoList() {
    return Consumer<AppData>(
      builder: (context, model, child) {
        todos = [];
        switch (_selectedItemIndex) {
          case 0:
            todos = model.all;
            break;
          case 1:
            todos = model.all.where((element) => element.isCompleted == true).toList();
            break;
          case 2:
            todos = model.all.where((element) => element.isCompleted == false).toList();
            break;
          default:
        }
        return Expanded(
          child: ListView.builder(itemBuilder: (context, index) {
            Todo val = todos[index];
            return TodoCard(todo: val,);
          },
            itemCount: todos.length,
          ),
        );
      },
    );
  }

  Widget _bottomNavigatorBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: 1.0, color: Color.fromRGBO(210, 211, 215, 1.0))),
      child: BottomNavigationBar(
          iconSize: 50.0,
          selectedItemColor: Colors.black,
          unselectedItemColor: Color.lerp(Colors.white, Colors.black, 0.2),
          currentIndex: _selectedItemIndex,
          onTap: _changeWidget,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.all_inbox), label: 'All'),
            BottomNavigationBarItem(
                icon: Icon(Icons.done_all), label: 'Complete'),
            BottomNavigationBarItem(
                icon: Icon(Icons.clear_all_outlined), label: 'Incomplete'),
          ]),
    );
  }
}
