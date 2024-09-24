import 'dart:io';
import 'dart:async';

import 'package:app_context/app_context.dart';

abstract interface class Server {
  Future<void> start({required final String address, required final int port});
}

abstract interface class Logger {
  Future<void> log({required final String message});
}

final class AnonymousServer implements Server {
  final Future<void> Function(String, int) _callback;

  const AnonymousServer({
    required final Future<void> Function(String, int) callback,
  }) : _callback = callback;

  @override
  Future<void> start({
    required final String address,
    required final int port,
  }) async =>
      await _callback.call(address, port);
}

final class Cmd implements Logger {
  const Cmd();

  @override
  Future<void> log({required final String message}) async => print(message);
}

final class StdHttpServer implements Server {
  const StdHttpServer();

  @override
  Future<void> start({
    required final String address,
    required final int port,
  }) async {
    final origin = await HttpServer.bind(address, port);
    final subscription = origin.listen((_) {}, cancelOnError: false);
    await subscription.asFuture();
  }
}

final class LaunchLogServer implements ContextNode<Server> {
  final ContextNode<Server> _origin;
  final Trait<Logger> _trait;

  const LaunchLogServer({
    required final ContextNode<Server> origin,
    required final Trait<Logger> trait,
  })  : _origin = origin,
        _trait = trait;

  @override
  Server attach({required final Context ctx}) => AnonymousServer(
        callback: (address, port) async {
          final logger = ctx.interpret(as: _trait);
          await logger.log(message: 'server started on $address:$port');
          final server = _origin.attach(ctx: ctx);
          await server.start(address: address, port: port);
        },
      );
}

final class App {
  final Server _server;

  static const _address = '127.0.0.1';
  static const _port = 8080;

  const App._internal({
    required Server server,
  }) : _server = server;

  factory App({required final Context ctx}) => App._internal(
        server: const LaunchLogServer(
          origin: CtxNodeAdapter(
            base: StdHttpServer(),
          ),
          trait: SimpleTrait<Logger>(),
        ).attach(ctx: ctx),
      );

  Future<void> run() async => await _server.start(
        address: _address,
        port: _port,
      );
}

final class AppContext implements Context {
  final Context _dependency;

  const AppContext._inner({
    required final Context dependency,
  }) : _dependency = dependency;

  factory AppContext() => const AppContext._inner(
        dependency: StdContext(
          state: InMemoryStorage(
            inner: {
              Logger: Cmd(),
            },
          ),
        ),
      );

  @override
  Form interpret<Form>({required final Trait<Form> as}) =>
      _dependency.interpret(as: as);
}

Future<void> main(final List<String> arguments) async => await runZonedGuarded(
      () async {
        final app = App(ctx: AppContext());
        await app.run();
      },
      (error, stack) => print({error, stack}.join('\n')),
    )?.whenComplete(() => exit(0));
