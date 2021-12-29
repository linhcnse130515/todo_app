import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manabie_todo_app/models/todo.dart';
import 'package:manabie_todo_app/providers/todos_state_notifier_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoCard extends StatefulWidget {
  final Todo todo;

  const TodoCard({Key key, this.todo}) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      height: 60.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(210, 211, 215, 1.0),
                offset: Offset(0, 5),
                blurRadius: 10.0)
          ]),
      child: Container(
        color: widget.todo.isCompleted == true ? Colors.green : Colors.white,
        key: Key("todoCard" + "${widget.todo.id}"),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              width: 200,
              alignment: Alignment.center,
              child: Text(
                widget.todo.title,
                key: Key("text" + "${widget.todo.id}"),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            widget.todo.isCompleted != true
                ? _buttonAccept(context)
                : Container(),
            _buttonRemove(context),
          ],
        ),
      ),
    );
  }

  Widget _buttonAccept(
    BuildContext context,
  ) {
    return Container(
      width: 70.0,
      height: 40.0,
      // ignore: deprecated_member_use
      child: RaisedButton(
        key: Key("acceptButton" + "${widget.todo.id}"),
        onPressed: () async {
          context.read(todosStateNotifierProvider).updateTodo(widget.todo.id, isCompleted: true);
        },
        shape: CircleBorder(side: BorderSide.none),
        color: Colors.white70,
        child: Icon(
          Icons.done,
          color: Colors.green,
          size: 25.0,
        ),
      ),
    );
  }

  Widget _buttonRemove(
    BuildContext context,
  ) {
    return Container(
      width: 70.0,
      height: 40.0,
      // ignore: deprecated_member_use
      child: RaisedButton(
        key: Key("removeButton" + "${widget.todo.id}"),
        onPressed: () async {
          context.read(todosStateNotifierProvider).deleteTodo(widget.todo.id);
        },
        shape: CircleBorder(side: BorderSide.none),
        color: Colors.white70,
        child: Icon(
          FontAwesomeIcons.trash,
          color: Colors.red,
          size: 25.0,
        ),
      ),
    );
  }
}
