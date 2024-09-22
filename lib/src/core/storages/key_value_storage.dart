/// more comfortable interface for immutable key value storage
abstract interface class KeyValueStorage<Key> {
  /// method to get value of required type by key from this storage
  ///
  /// [as] param - is the key of required value, like in JSON or Map type
  Value fetch<Value>({required final Key as});
}