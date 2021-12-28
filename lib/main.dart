import 'package:flutter/material.dart';
import 'package:manabie_todo_app/repositories/todos_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manabie_todo_app/screens/home_screen.dart';
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
    return ProviderScope(
      child: MaterialApp(
        title: 'Todo App',
        theme: MyTheme().buildTheme(),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}