/// Helper code and utilities that are used to power games in `bin/`.
///
/// Nothing in this API is stable, and it may be changed without notice.
@experimental
library dartcade;

import 'dart:io';

import 'package:griddle/griddle.dart';
import 'package:meta/meta.dart';
import 'package:neokeys/neokeys.dart';
import 'package:stack_trace/stack_trace.dart';

/// Runs a game loop, which invokes [update] on every frame.
Future<void> gameLoop(
  void Function(Screen, BufferedKeys) update, {
  Duration framesPerSecond = const Duration(milliseconds: 1000 ~/ 30),
  void Function(Screen)? onStart,
}) async {
  stdin.setRawMode(true);

  final display = Display.fromAnsiTerminal(
    stdout,
    width: () => stdout.terminalColumns,
    height: () => stdout.terminalLines,
  );
  final screen = Screen.display(display);

  if (onStart != null) {
    onStart(screen);
  }

  final keys = BufferedKeys.async(stdin);

  var isRunning = true;
  await for (final void _ in Stream.periodic(framesPerSecond)) {
    try {
      update(screen, keys);
      screen.update();

      // Universal quit for ESC.
      if (keys.isPressed(27)) {
        isRunning = false;
        stderr.writeln('ESC: Exiting...');
      }

      keys.clear();
    } on Object catch (e, s) {
      stderr
        ..writeln('Unhandled exception: $e')
        ..writeln(Trace.from(s).terse);
      isRunning = false;
    }
    if (!isRunning) {
      stdin.setRawMode(false);
      keys.cancel();
      break;
    }
  }
}

extension on Stdin {
  // ignore: avoid_positional_boolean_parameters
  void setRawMode(bool rawMode) {
    stdin
      ..echoMode = !rawMode
      ..lineMode = !rawMode;
  }
}
