import 'package:app_context/app_context.dart';
import 'package:test/test.dart';

final class Adapted {
  const Adapted();
}

final class MockContext implements Context {
  const MockContext();

  @override
  Form interpret<Form>({required final Trait<Form> as}) =>
      throw UnimplementedError();
}

void main() {
  group('context node adapter testing', () {
    late final Adapted adapted;
    late final Adapted Function() result;
    setUpAll(() {
      adapted = const Adapted();
      final adapter = CtxNodeAdapter(base: adapted);
      final context = const MockContext();
      result = () => adapter.attach(ctx: context);
    });
    test(
      'Adapted does not implements ContextNode interface',
      () => expect(adapted is ContextNode<Adapted>, false),
    );
    test(
      'CtxNodeAdapter<Adapted> does not implements ContextNode with other generic',
      () => expect(adapted is ContextNode<Object>, false),
    );
    test(
      'attach context does not throw errors',
      () => expect(result, returnsNormally),
    );
    test(
      'returns exactly the encapsulated adapted object',
      () => expect(result(), adapted),
    );
  });
}
