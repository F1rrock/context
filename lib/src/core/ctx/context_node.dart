import 'package:context/src/core/ctx/context.dart';

/// ContextNode will wrap a Base object (generic type) to let the methods of the base object know about
/// context attached context using partial application concept from functional programming style
abstract interface class ContextNode<Base> {
  /// this method will attach context object to "encapsulate" it for methods in Base object
  ///
  /// [ctx] param - is the context that will encapsulate value for nested functions (methods)
  Base attach({required final Context ctx});
}