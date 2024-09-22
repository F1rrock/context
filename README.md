# Context Library

**Context** is a Dart library that provides a flexible and lightweight mechanism for passing context objects throughout your system. It enables loose coupling between components by utilizing anonymous objects, functional programming concepts like partial application, and key-value storage structures. This allows for easy dependency injection (DI) and configuration management without high coupling.

## Features

- **Context Propagation**: Pass context objects through the system using a flexible interface.
- **Partial Application**: Attach context to methods and functions dynamically, enabling cleaner and more functional design.
- **Anonymous Objects**: Implement context in an immutable, lightweight manner, similar to anonymous classes in Java.
- **Key-Value Storage**: Store and retrieve configuration data or service instances using an efficient key-value model.
- **Flexible DI**: Achieve dependency injection without tight coupling using context interpretation and traits.
- **Flyweight Constructors**: Use shared configurations across isolated parts of your system.

## Getting Started

### Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
context: ^1.0.0
```

Then, run:

```bash
dart pub get
```

### Usage

#### Defining a Context

A `Context` object stores configuration information that is passed between different system components. The context is immutable and is typically injected at the application startup.

```dart
import 'package:context/src/core/traits/trait.dart';

/// An object that implements the Context interface to pass configuration data.
abstract interface class Context {
/// Interpret the context as a specific type (Form).
///
/// [as] specifies the trait or interface required for interpretation.
Form interpret<Form>({required final Trait<Form> as});
}
```

#### Attaching Context to Objects

To pass context into system components, use the `ContextNode` interface, which allows partial application by attaching the context to a base object.

```dart
import 'package:context/src/core/ctx/context.dart';

/// A wrapper for Base objects to pass context using partial application.
abstract interface class ContextNode<Base> {
/// Attach a context to a base object.
Base attach({required final Context ctx});
}
```

#### Key-Value Storage for Context

The library also provides an interface for immutable key-value storage, which stores the actual configuration values.

```dart
/// A key-value storage interface for context configurations.
abstract interface class KeyValueStorage<Key> {
/// Fetch a value of the required type by key.
Value fetch<Value>({required final Key as});
}
```

#### Interpreting Context with Traits

Traits are used to interpret the context. When a component requires a specific service or object, the trait retrieves the required value from the key-value storage inside the context.

```dart
/// A wrapper for types passed to the context's interpret method.
abstract interface class Trait<Form> {
/// Fetch the value required by the trait from the context's storage.
///
/// [to] is the storage used to retrieve the value.
///
Form refer({required final KeyValueStorage<Type> to});
}
```

## License

This library is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
