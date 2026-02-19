import 'dart:math';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/game/audio_manager.dart';
import 'basket.dart';
import 'fruit.dart';

class FruitCatcherGame extends FlameGame
  with HasCollisionDetection {

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);
  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  final Random random = Random();
  double spawnTimer = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(Basket());
    // Play background music
    AudioManager().playBackgroundMusic(); // Update
  }
  void incrementScore() {
    scoreNotifier.value++;
  }

  @override
  void update(double dt) {
    super.update(dt);
    spawnTimer += dt;

  if (spawnTimer > 1) {
    spawnFruit();
    spawnTimer = 0;
    }
  }

  void spawnFruit() {
  final xPosition = random.nextDouble() * size.x;

  add(
    Fruit(
      position: Vector2(xPosition, -20),
    ),
  );
}

}

