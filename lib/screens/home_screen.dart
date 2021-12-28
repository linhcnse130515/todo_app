import 'package:flutter/material.dart';
import 'package:manabie_todo_app/models/todo.dart';
import 'package:manabie_todo_app/providers/todos_state_notifier_provider.dart';
import 'package:manabie_todo_app/widgets/TodoCard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _titleController = TextEditingController();
  List<Todo> list = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }

  void _fetchData() {
    context.read(todosStateNotifierProvider).getTodos();
  }

  void _addTodo(String title) {
    context.read(todosStateNotifierProvider).createTodo(title);
    _titleController.clear();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        setState(() {
          _selectedIndex = 0;
        });
        break;
      case 1:
        setState(() {
          _selectedIndex = 1;
        });
        break;
      case 2:
        setState(() {
          _selectedIndex = 2;
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      List<Todo> list = [];
      debugPrint(list.toString());
      switch (_selectedIndex) {
        case 0:
          list = watch(todosStateNotifierProvider.state);
          break;
        case 1:
          list = watch(todosStateNotifierProvider.state)
              .where((todo) => (todo.getIsCompleted == false))
              .toList();
          break;
        case 2:
          list = watch(todosStateNotifierProvider.state)
              .where((todo) => (todo.getIsCompleted == true))
              .toList();
          break;
        default:
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Center(child: Text("Todo App")),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
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
                          Theme.of(context).primaryColor),
                    ),
                    key: Key("addButton"),
                    onPressed: () => _addTodo(_titleController.text),
                    child: Icon(Icons.add))
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                final value = list[index];
                return TodoCard(todo: value,);
              },
              itemCount: list.length,
            )),
          ],
        ),
        bottomNavigationBar: _bottomNavigatorBar(context),
      );
    });
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
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
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
