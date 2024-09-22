import 'package:context/src/core/storages/key_value_storage.dart';

/// wrapper for required type to pass it to interpret of context object
abstract interface class Trait<Form> {
  /// method that will fetch required by trait value from passed storage from context object
  ///
  /// [to] param - is storage that will use to fetch required value using key as type of generic
  Form refer({required final KeyValueStorage<Type> to});
}