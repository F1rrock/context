import 'package:app_context/app_context.dart';

/// implementation of Trait interface that only refers to fetch value from passed storage
final class SimpleTrait<Form> implements Trait<Form> {
  const SimpleTrait();

  /// passes th generic type as key to storage using Visitor design pattern
  @override
  Form refer({required final KeyValueStorage<Type> to}) => to.fetch(as: Form);
}
