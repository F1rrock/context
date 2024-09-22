import 'package:context/src/core/errors/no_value_with_such_key.dart';
import 'package:context/src/core/errors/unresolved_value.dart';
import 'package:context/src/core/storages/key_value_storage.dart';

/// implementation of the most common variation of key value storage, just adapter for Map type
final class InMemoryStorage<Key> implements KeyValueStorage<Key> {
  final Map<Key, dynamic> _inner;

  const InMemoryStorage({
    required final Map<Key, dynamic> inner,
  }) : _inner = inner;

  /// method that will return value with required type using passed key with some based checks
  @override
  Value fetch<Value>({required final Key as}) {
    final value = _inner[as];
    if (value != null) {
      try {
        return value;
      } catch (_) {
        throw const UnresolvedValue();
      }
    }
    throw const NoValueWithSuchKey();
  }
}
