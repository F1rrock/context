import 'package:app_context/app_context.dart';
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

final class FakeValue {
  const FakeValue();
}

final class FakeTrait<Form> implements Trait<Form> {
  const FakeTrait();

  @override
  Form refer({required final KeyValueStorage<Type> to}) => to.fetch(as: Form);
}

void main() {
  group('standard context testing', () {
    late MockKeyValueStorage storage;
    late final Context context;
    setUpAll(() {
      storage = MockKeyValueStorage();
      context = StdContext(state: storage);
    });
    group('storage returns the value (FakeValue)', () {
      late final FakeValue value;
      late final FakeValue Function() actual;
      setUpAll(() {
        value = FakeValue();
        storage.behaviour = (_) => value;
        actual = () => context.interpret(as: FakeTrait<FakeValue>());
      });
      test('interpret of context does not throw errors', () {
        expect(actual, returnsNormally);
        assert(storage.verify(1));
      });
      test('context returns the encapsulated value', () {
        expect(actual(), value);
        assert(storage.verify(1));
      });
    });
    group('storage fetching throws an error', () {
      late final FakeValue Function() actual;
      setUpAll(() {
        storage.behaviour = (_) => throw const UnresolvedValue();
        actual = () => context.interpret(as: FakeTrait<FakeValue>());
      });
      test('interpret of context throws an unresolved value', () {
        expect(actual, throwsA(TypeMatcher<UnresolvedValue>()));
        assert(storage.verify(1));
      });
    });
  });
}
