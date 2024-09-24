import 'package:app_context/src/core/traits/trait.dart';

/// an object that implements Context interface will pass through components of system directly.
/// this object will store some configuration info to let "decorators" know, which implementation
/// of some kinds of interface using in the whole system. Required to separate DI on many isolated
/// parts with flyweight constructors and share system configuration info between all of them
/// without "high coupling". Be default, supposed that context will immutable and once injected
/// during the launch of the application
abstract interface class Context {
  /// components that require an object with, for example interface A will call context object
  /// and interpret this as Trait<A> and if context has an implementation of A inside, it will
  /// return injected in context A object
  ///
  /// [as] param is the trait or "interface" of required interpretation form
  /// for example context should be interpreted as type A, to achieve this has
  /// to pass Trait with A generic as param
  Form interpret<Form>({required final Trait<Form> as});
}