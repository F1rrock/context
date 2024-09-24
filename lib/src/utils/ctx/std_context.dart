import 'package:app_context/src/core/ctx/context.dart';
import 'package:app_context/src/core/storages/key_value_storage.dart';
import 'package:app_context/src/core/traits/trait.dart';

/// implementation of Context interface that acts as proxy for encapsulated of key value storage
final class StdContext implements Context {
  final KeyValueStorage<Type> _state;

  const StdContext({
    required final KeyValueStorage<Type> state,
  }) : _state = state;

  /// transmit encapsulated storage to passed trait using variation of Visitor design pattern
  @override
  Form interpret<Form>({required final Trait<Form> as}) => as.refer(to: _state);
}
