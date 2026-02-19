import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../fruit_catcher_game.dart';
import 'basket.dart';

enum FruitType { apple, banana, orange, strawberry }
class Fruit extends PositionComponent with HasGameRef<FruitCa
tcherGame>, CollisionCallbacks {
 final FruitType type;
 final double fallSpeed = 200;
 final Random random = Random();
 Fruit({super.position})
 : type = FruitType.values[Random().nextInt(FruitType.valu
es.length)],
 super(size: Vector2.all(40));

  @override
 Future<void> onLoad() async {
 await super.onLoad();
 anchor = Anchor.center;
 add(CircleHitbox());
 }

 @override
 void update(double dt) {
 super.update(dt);
 // Move fruit down
 position.y += fallSpeed * dt;
 // Remove if off screen
 if (position.y > gameRef.size.y + 50) {
 removeFromParent();
 }
 }

 @override
 void onCollision(Set<Vector2> intersectionPoints, PositionC
omponent other) {
 super.onCollision(intersectionPoints, other);
 if (other is Basket) {
 gameRef.incrementScore();
 removeFromParent();
 }
 }
