import 'package:meta/meta.dart';

/// Represents a ball in the pong game.
@sealed
class Ball {
  /// X-coordinate in a 2D system.
  int x;

  /// Y-coordinate in a 2D system.
  int y;

  /// Speed in the [x] dimension and direction.
  int xVelocity;

  /// Speed in the [y] dimension and direction.
  int yVelocity;

  /// Creates a new ball with the provided properties.
  Ball({
    required this.x,
    required this.y,
    required this.xVelocity,
    required this.yVelocity,
  });

  /// Given the [xVelocity] and [yVelocity], updates [x] and [y] accordingly.
  void update() {
    x += xVelocity;
    y += yVelocity;
  }

  /// Reverses the [xVelocity].
  void reverseX() {
    xVelocity *= -1;
  }

  /// Reversed the [yVelocity].
  void reverseY() {
    yVelocity *= -1;
  }

  /// Sets the provided properties.
  void reset({int? x, int? y, int? xVelocity, int? yVelocity}) {
    this.x = x ?? this.x;
    this.y = y ?? this.y;
    this.xVelocity = xVelocity ?? this.xVelocity;
    this.yVelocity = yVelocity ?? this.yVelocity;
  }

  /// Whether the ball has hit the [paddle].
  bool intersects(Paddle paddle) {
    return x >= paddle.x &&
        x <= paddle.x + paddle.width &&
        y >= paddle.y &&
        y <= paddle.y + paddle.height;
  }
}

/// Represents a paddle in the pong game.
@sealed
class Paddle {
  /// X-coordinate in a 2D system.
  int x;

  /// Y-coordinate in a 2D system.
  int y;

  /// Height of the paddle.
  int height;

  /// Width of the paddle.
  int width;

  /// Speed the paddle is moving (either positive or negative).
  ///
  /// Effects [moveLeft] and [moveRight].
  int speed;

  /// Creates a new paddle with the provided properties.
  Paddle({
    required this.x,
    required this.y,
    required this.height,
    required this.width,
    required this.speed,
  });

  /// Moves the paddle left according to the [speed].
  void moveLeft() {
    if (x > 0) {
      x -= speed;
    }
    if (x < 0) {
      x = 0;
    }
  }

  /// Moves the paddle right according to the [speed].
  void moveRight(int maxWidth) {
    if (x < maxWidth - width) {
      x += speed;
    }
    if (x + width > maxWidth) {
      x = maxWidth - width;
    }
  }
}
