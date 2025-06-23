import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapptest/core/components/default_background.dart';

void main() {
  testWidgets('Given when Auth is true render gradient', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(size: Size(1080, 1920)),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: DefaultBackground(isAuth: true),
        ),
      ),
    );

    final containerFinder = find.byType(Container);
    final containerWidget = tester.widget<Container>(containerFinder);

    final decoration = containerWidget.decoration as BoxDecoration;

    expect(decoration.gradient, isNotNull);
    expect(decoration.color, isNull);
  });

  testWidgets('Given when Auth is false render solid colors', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(size: Size(1080, 1920)),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: DefaultBackground(isAuth: false),
        ),
      ),
    );

    final containerFinder = find.byType(Container);
    final containerWidget = tester.widget<Container>(containerFinder);

    final decoration = containerWidget.decoration as BoxDecoration;

    expect(decoration.gradient, isNull);
    expect(decoration.color, const Color(0xFF09141A));
  });
}
