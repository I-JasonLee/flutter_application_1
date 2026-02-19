import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Basket extends PositionComponent
  with HasGameRef, CollisionCallbacks, DragCallbacks {

  Basket() : super(size: Vector2(80, 60));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    position = Vector2(
      gameRef.size.x / 2,
      gameRef.size.y - 100
    );

    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
  position.x += event.localDelta.x;

  // Batasi agar tidak keluar layar kiri
  if (position.x < size.x / 2) {
    position.x = size.x / 2;
  }

  // Batasi agar tidak keluar layar kanan
  if (position.x > gameRef.size.x - size.x / 2) {
    position.x = gameRef.size.x - size.x / 2;
  }
}

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
    ..color = Colors.brown
    ..style = PaintingStyle.fill;

    // Draw basket body
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      const Radius.circular(10),
    );

     canvas.drawRRect(rect, paint);

    // Draw basket handle
    final handlePaint = Paint()
      ..color = Colors.brown[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

     final handlePath = Path()
      ..moveTo(10, 0)
      ..quadraticBezierTo(
        size.x / 2,
        -20,
        size.x - 10,
        0,
      );

    canvas.drawPath(handlePath, handlePaint);
  }
}