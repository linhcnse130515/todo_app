import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:manabie_todo_app/models/todo.dart';
import 'package:manabie_todo_app/providers/todos_repository_provider.dart';
import 'package:manabie_todo_app/repositories/i_todos_repository.dart';
import 'package:manabie_todo_app/screens/home_screen.dart';
import 'package:manabie_todo_app/widgets/TodoCard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group("Home Screen ", () {
    _pumpTestWidget(WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(overrides: [
        todosRepositoryProvider
            .overrideWithProvider(Provider((ref) => MockTodosRepository2()))
      ], child: MaterialApp(home: HomeScreen())));
    }

    testWidgets("empty state", (WidgetTester tester) async {
      await _pumpTestWidget(tester);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(TodoCard), findsNothing);
    });

    testWidgets("update list when a todo is added ",
        (WidgetTester tester) async {
      await _pumpTestWidget(tester);
      String expectedTitle = "todo title";
      await tester.enterText(find.byKey(ValueKey("title")), expectedTitle);
      await tester.tap(find.byKey(Key("addButton")));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(tester.widgetList(find.byType(TodoCard)), [
        isA<TodoCard>()
            .having((s) => s.todo.title, "check first element value", expectedTitle)
      ]);
      expect(find.byType(TodoCard), findsOneWidget);
      expect(find.text(expectedTitle), findsOneWidget);
    });
    testWidgets("update list when a todo is deleted ",
        (WidgetTester tester) async {
      await _pumpTestWidget(tester);
      String expectedTitle = "todo title";
      //Add first todo
      await tester.enterText(find.byKey(ValueKey("title")), expectedTitle);
      await tester.tap(find.byKey(Key("addButton")));
      //Add second todo
      await tester.enterText(find.byKey(ValueKey("title")), "another title");
      await tester.tap(find.byKey(Key("addButton")));
      await tester.pumpAndSettle();

      //Tap delete button
      await tester.tap(find.byKey(Key("removeButton1")));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(TodoCard), findsOneWidget);
      expect(find.text(expectedTitle), findsNothing);
    });

    testWidgets("filter complete todos", (WidgetTester tester) async {
      await _pumpTestWidget(tester);
      //Add first todo

      await tester.enterText(find.byKey(ValueKey("title")), "completed title");
      await tester.tap(find.byKey(Key("addButton")));
      //Add second todo
      await tester.enterText(
          find.byKey(ValueKey("title")), "incompleted title");
      await tester.tap(find.byKey(Key("addButton")));

      //Click check button 1
      await tester.tap(find.byKey(Key("acceptButton1")));
      await tester.pump();

      //Click Completed Button on Bottom Bar
      await tester.tap(find.byKey(Key("completeButton")));
      await tester.pump();

      expect(find.byKey(Key("text2")), findsNothing);
      expect(find.byKey(Key("text1")), findsOneWidget);
    });

    testWidgets("filter incomplete todos", (WidgetTester tester) async {
      await _pumpTestWidget(tester);
      //Add first todo
      await tester.enterText(find.byKey(ValueKey("title")), "completed title");
      await tester.tap(find.byKey(Key("addButton")));

      //Add second todo
      await tester.enterText(
          find.byKey(ValueKey("title")), "incompleted title");
      await tester.tap(find.byKey(Key("addButton")));

      //Add third todo
      await tester.enterText(
          find.byKey(ValueKey("title")), "incompleted title");
      await tester.tap(find.byKey(Key("addButton")));

      //Click check button 1
      await tester.tap(find.byKey(Key("acceptButton1")));
      await tester.pump();

      //Click Incomplete Button on Bottom Bar
      await tester.tap(find.byKey(Key("incompleteButton")));
      await tester.pump();

      expect(find.byKey(Key("text1")), findsNothing);
      expect(find.byKey(Key("text2")), findsOneWidget);
      expect(find.byKey(Key("text3")), findsOneWidget);
    });

    testWidgets("filter all todos", (WidgetTester tester) async {
      await _pumpTestWidget(tester);
      //Add first todo

      await tester.enterText(find.byKey(ValueKey("title")), "completed title");
      await tester.tap(find.byKey(Key("addButton")));

      //Add second todo
      await tester.enterText(find.byKey(ValueKey("title")), "incompleted title");
      await tester.tap(find.byKey(Key("addButton")));

      //Add third todo
      await tester.enterText(find.byKey(ValueKey("title")), "completed title");
      await tester.tap(find.byKey(Key("addButton")));

      //Click check button 1
      await tester.tap(find.byKey(Key("acceptButton1")));
      await tester.pump();

      //Click check button 3
      await tester.tap(find.byKey(Key("acceptButton3")));
      await tester.pump();

      //Click Completed Button on Bottom Bar
      await tester.tap(find.byKey(Key("completeButton")));
      await tester.pump();

      expect(find.byKey(Key("text1")), findsOneWidget);
      expect(find.byKey(Key("text2")), findsNothing);
      expect(find.byKey(Key("text3")), findsOneWidget);

      //Back to All screen
      await tester.tap(find.byKey(Key("allButton")));
      await tester.pump();

      expect(find.byKey(Key("text1")), findsOneWidget);
      expect(find.byKey(Key("text2")), findsOneWidget);
      expect(find.byKey(Key("text3")), findsOneWidget);
    });

    group("Todo ", () {
      testWidgets("update UI when a todo is completetd",
          (WidgetTester tester) async {
        await _pumpTestWidget(tester);
        //Add first todo
        String expectedTitle = "todo title";
        await tester.enterText(find.byKey(ValueKey("title")), expectedTitle);
        await tester.tap(find.byKey(Key("addButton")));
        //Add second todo
        await tester.enterText(find.byKey(ValueKey("title")), "another title");
        await tester.tap(find.byKey(Key("addButton")));

        //Click check button 1
        await tester.tap(find.byKey(Key("acceptButton1")));
        await tester.pumpAndSettle();

        final text = tester.widget<Container>(find.byKey(Key("todoCard1")));
        expect(find.byKey(Key("text1")), findsOneWidget);

        expect(text.color, Colors.green);

        expect(find.byKey(Key("acceptButton1")), findsNothing);
      });
    });
  });
}

class MockTodosRepository2 implements ITodoRepository {
  @override
  Future<void> deleteTodo(int index) {}

  @override
  Future<List<Todo>> getTodos() async {
    return [];
  }

  @override
  Future<void> insertTodo(Todo todo) {}

  @override
  Future<void> updateTodo(Todo todo) {}
}
