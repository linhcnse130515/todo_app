// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Todo App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    final addButtonFinder = find.byValueKey("addButton");
    final titleFinder = find.byValueKey("title");

    final checkButton1Finder = find.byValueKey("acceptButton1");
    final text1Finder = find.byValueKey("text1");
    final deleteButton1Finder = find.byValueKey("removeButton1");

    final checkButton2Finder = find.byValueKey("acceptButton2");
    final text2Finder = find.byValueKey("text2");

    final incompletedButtonFinder = find.byValueKey("incompleteButton");
    final completedButtonFinder = find.byValueKey("completeButton");
    final allButtonFinder = find.byValueKey("allButton");
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test("add two todos", () async {
      await driver.tap(titleFinder);
      await driver.enterText("testing add todo1");
      await driver.tap(addButtonFinder);

      await driver.tap(titleFinder);
      await driver.enterText("testing add todo2");
      await driver.tap(addButtonFinder);

      expect(await driver.getText(text1Finder), "testing add todo1");
      expect(await driver.getText(text2Finder), "testing add todo2");
    });

    test("click check one todo", () async {
      await driver.tap(checkButton1Finder);
    });

    test("switch to incompletedScreen", () async {
      await driver.tap(incompletedButtonFinder);
    });

    test("switch completedScreen", () async {
      await driver.tap(completedButtonFinder);
    });

    test("switch homeScreen", () async {
      await driver.tap(allButtonFinder, timeout: Duration(seconds: 1));
    });

    test("delete a todo", () async {
      await driver.tap(deleteButton1Finder);
    });
  });
}
