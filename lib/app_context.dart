/// # App context library
///
/// Context is a Dart library that provides a flexible and lightweight mechanism for passing
/// context objects throughout your system. It enables loose coupling between components by
/// utilizing anonymous objects, functional programming concepts like partial application,
/// and key-value storage structures. This allows for easy dependency injection (DI) and
/// configuration management without high coupling.
///
/// Features
/// - Context Propagation: Pass context objects through the system using a flexible interface.
/// - Partial Application: Attach context to methods and functions dynamically, enabling cleaner and more functional design.
/// - Anonymous Objects: Implement context in an immutable, lightweight manner, similar to anonymous classes in Java.
/// - Key-Value Storage: Store and retrieve configuration data or service instances using an efficient key-value model.
/// - Flexible DI: Achieve dependency injection without tight coupling using context interpretation and traits.
/// - Flyweight Constructors: Use shared configurations across isolated parts of your system.
///
/// App components
/// - `Context` and `ContextNode` for managing context trees.
/// - Custom errors like `NoValueWithSuchKey` and `UnresolvedValue`.
/// - Storage solutions like `KeyValueStorage` and `InMemoryStorage`.
/// - Utilities for context node adaptation and standard context handling.
///
/// This library is designed to be flexible and adaptable to different types of applications.
library app_context;

export 'package:app_context/src/core/ctx/context.dart' show Context;
export 'package:app_context/src/core/ctx/context_node.dart' show ContextNode;
export 'package:app_context/src/core/errors/no_value_with_such_key.dart'
    show NoValueWithSuchKey;
export 'package:app_context/src/core/errors/unresolved_value.dart'
    show UnresolvedValue;
export 'package:app_context/src/core/storages/key_value_storage.dart'
    show KeyValueStorage;
export 'package:app_context/src/core/traits/trait.dart' show Trait;
export 'package:app_context/src/utils/adapters/ctx_node_adapter.dart'
    show CtxNodeAdapter;
export 'package:app_context/src/utils/ctx/std_context.dart' show StdContext;
export 'package:app_context/src/common/in_memory_storage.dart'
    show InMemoryStorage;
export 'package:app_context/src/common/simple_trait.dart' show SimpleTrait;
