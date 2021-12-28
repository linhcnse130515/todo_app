import 'package:flutter/material.dart';
import 'package:manabie_todo_app/providers/app_data.dart';
import 'package:manabie_todo_app/repositories/todos_repository.dart';
import 'package:manabie_todo_app/routes/routes_master.dart';
import 'package:provider/provider.dart';

import 'Utils/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TodoRepository().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Todo App',
        theme: MyTheme().buildTheme(),
        initialRoute: 'home',
        routes: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}