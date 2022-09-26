import 'dart:math';

import 'package:dartcade/dartcade.dart';
import 'package:dartcade/src/pong.dart';
import 'package:griddle/griddle.dart';

/// A terminal-based pong game written in Dart.
///
/// Adapted from <https://github.com/jalletto/pongo>.
void main() async {
  final random = Random();
  late final Ball ball;
  late final List<Paddle> paddles;

  await gameLoop(
    onStart: (screen) {
      final width = screen.width;
      final height = screen.height;

      ball = Ball(
        x: width ~/ 2,
        y: height ~/ 2,
        xVelocity: random.nextBool() ? 1 : -1,
        yVelocity: random.nextBool() ? 1 : -1,
      );

      paddles = [
        Paddle(
          width: 8,
          height: 1,
          x: width ~/ 2,
          y: 1,
          speed: 5,
        ),
        Paddle(
          width: 8,
          height: 1,
          x: width ~/ 2,
          y: height - 2,
          speed: 5,
        ),
      ];
    },
    (screen, keys) {
      // Clear everthing from the last frame so we can redraw.
      screen.clear();

      // Check collisions.
      // Update the score if the ball will go out of bounds top/bottom.
      if (paddles.any(ball.intersects)) {
        ball.reverseY();
        // Determine what the new x direction should be.
        final paddle = paddles.firstWhere(ball.intersects);
        if (ball.x <= paddle.x + paddle.width ~/ 2) {
          ball.xVelocity = -1;
        } else {
          ball.xVelocity = 1;
        }
      } else if (ball.y + ball.yVelocity <= 0) {
        ball.reset(
          x: screen.width ~/ 2,
          y: screen.height ~/ 2,
          xVelocity: random.nextBool() ? 1 : -1,
          yVelocity: random.nextBool() ? 1 : -1,
        );
      } else if (ball.y + ball.yVelocity >= screen.height) {
        ball.reset(
          x: screen.width ~/ 2,
          y: screen.height ~/ 2,
          xVelocity: random.nextBool() ? 1 : -1,
          yVelocity: random.nextBool() ? 1 : -1,
        );
      }

      // Bounce off the sides.
      if (ball.x + ball.xVelocity <= 0) {
        ball.reverseX();
      }
      if (ball.x + ball.xVelocity >= screen.width) {
        ball.reverseX();
      }

      // Update the ball.
      ball.update();

      // Update the paddles. We assume P1 is the AI and P2 is the Human.
      _aiHandlePaddle(paddles[0], ball, screen.width);
      if (keys.isPressed('a'.codeUnitAt(0))) {
        paddles[1].moveLeft();
      }
      if (keys.isPressed('d'.codeUnitAt(0))) {
        paddles[1].moveRight(screen.width);
      }

      // Display the ball and paddles.
      screen.set(
        ball.x,
        ball.y,
        Cell('●'),
      );

      for (final paddle in paddles) {
        screen.fill(
          x: paddle.x,
          y: paddle.y,
          width: paddle.width,
          height: paddle.height,
          character: '█'.codeUnitAt(0),
        );
      }
    },
  );
}

void _aiHandlePaddle(Paddle paddle, Ball ball, int width) {
  // If the ball is moving away, we do nothing.
  if (ball.yVelocity != -1) {
    return;
  }

  // Try to move towards where the ball will be.
  if (ball.xVelocity == 1) {
    if (ball.x > paddle.x) {
      paddle.moveRight(width);
    }
  } else {
    if (ball.x < paddle.x) {
      paddle.moveLeft();
    }
  }
}
