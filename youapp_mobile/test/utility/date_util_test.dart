import 'package:flutter_test/flutter_test.dart';
import 'package:youapptest/utility/date_util.dart';

void main() {
  group('UserUtils.calculateAge', () {
    test('Given when the birthday is the past returns correct age', () {
      final birthDate = DateTime(DateTime.now().year - 25, 1, 1); // Jan 1
      final age = DateUtil.calculateAge(birthDate);
      expect(age, 25);
    });

    test('Given when birthday is today returns correct age', () {
      final today = DateTime.now();
      final birthDate = DateTime(today.year - 30, today.month, today.day);
      final age = DateUtil.calculateAge(birthDate);
      expect(age, 30);
    });

    test('Given when birthday is in the future returns correct age', () {
      final today = DateTime.now();
      final birthDate = DateTime(today.year - 20, today.month + 1, 1);
      final age = DateUtil.calculateAge(birthDate);
      expect(age, 19);
    });
  });
}
