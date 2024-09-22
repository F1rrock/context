import 'package:context/context.dart';
import 'package:test/test.dart';

final class MockKeyValueStorage implements KeyValueStorage<Type> {
  late dynamic Function(Type) _callback;
  int _calls;

  MockKeyValueStorage() : _calls = 0 {
    _callback = (_) {};
  }

  set behaviour(dynamic Function(Type) value) {
    _callback = value;
    _calls = 0;
  }

  @override
  Value fetch<Value>({required final Type as}) {
    _calls++;
    return _callback.call(as);
  }

  bool verify(final int calls) {
    final memory = _calls;
    _calls = 0;
    return memory == calls;
  }
}

final class FakeForm {
  const FakeForm();
}

void main() {
  group('simple trait testing', () {
    late final MockKeyValueStorage storage;
    late final Trait<FakeForm> trait;
    setUpAll(() {
      storage = MockKeyValueStorage();
      trait = SimpleTrait<FakeForm>();
    });
    group('storage returns FakeForm type', () {
      late final form = FakeForm();
      late final FakeForm actual;
      setUpAll(() {
        storage.behaviour = (type) => type == FakeForm ? form : Object();
        actual = trait.refer(to: storage);
      });
      test('simple trait returns FakeForm also', () => expect(actual, form));
      test('trait with other form returns other value',
          () => expect(SimpleTrait<Object>().refer(to: storage), isNot(form)));
    });
    group('storage throws an UnresolvedValue error', () {
      late final FakeForm Function() actual;
      setUpAll(() {
        storage.behaviour = (_) => throw const UnresolvedValue();
        actual = () => trait.refer(to: storage);
      });
      test('simple trait also throws an UnresolvedValue error',
          () => expect(actual, throwsA(TypeMatcher<UnresolvedValue>())));
    });
  });
}
