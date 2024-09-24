import 'package:app_context/app_context.dart';
import 'package:test/test.dart';

void main() {
  group('in memory storage testing', () {
    late final KeyValueStorage<String> storage;
    late final Map<String, dynamic> mapping;
    setUpAll(() {
      mapping = {'index': 123};
      storage = InMemoryStorage(inner: mapping);
    });
    test('value of required type is founded', () {
      const expected = 123;
      final int actual = storage.fetch(as: 'index');
      expect(actual, expected);
    });
    test('value of is founded, but type is wrong', () {
      String actual() => storage.fetch(as: 'index');
      expect(actual, throwsA(TypeMatcher<UnresolvedValue>()));
    });
    test('value with such key is not founded', () {
      actual() => storage.fetch(as: 'unknown');
      expect(actual, throwsA(TypeMatcher<NoValueWithSuchKey>()));
    });
  });
}