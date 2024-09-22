import 'package:context/src/core/ctx/context.dart';
import 'package:context/src/core/ctx/context_node.dart';

/// adapts required generic type to ContextNode interface with the same type
final class CtxNodeAdapter<Base> implements ContextNode<Base> {
  final Base _base;

  const CtxNodeAdapter({
    required final Base base,
  }) : _base = base;

  /// just returns encapsulated value of generic type ignoring passed context
  @override
  Base attach({required final Context ctx}) => _base;
}
