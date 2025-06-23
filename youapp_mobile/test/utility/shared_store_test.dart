import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapptest/utility/shared_store.dart';

void main() {
  setUp(() {
    // Initialize mock shared preferences before each test
    SharedPreferences.setMockInitialValues({});
  });

  group('SharedStorage', () {
    test(
      'Given when saveData and getData are called store and retrieve values',
      () async {
        await SharedStorage.saveData('token', 'abc123');
        final result = await SharedStorage.getData('token');
        expect(result, 'abc123');
      },
    );

    test(
      'Given when getData is called when key does not existreturns null ',
      () async {
        final result = await SharedStorage.getData('nonexistent');
        expect(result, isNull);
      },
    );

    test('Given when removeItem is called removes the value', () async {
      await SharedStorage.saveData('removeKey', 'toBeRemoved');
      await SharedStorage.removeItem('removeKey');
      final result = await SharedStorage.getData('removeKey');
      expect(result, isNull);
    });

    test('Given when clear is called remove all values', () async {
      await SharedStorage.saveData('key1', 'value1');
      await SharedStorage.saveData('key2', 'value2');
      await SharedStorage.clear();

      final result1 = await SharedStorage.getData('key1');
      final result2 = await SharedStorage.getData('key2');

      expect(result1, isNull);
      expect(result2, isNull);
    });
  });
}
