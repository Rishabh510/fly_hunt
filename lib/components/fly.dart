import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fly_hunt/fly-hunt-game.dart';

class Fly {
  final FlyHuntGame game;
  Rect flyRect;
  Paint flyPaint;
  bool isDead = false;
  bool isOffScreen = false;

  Fly(this.game, double x, double y) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    flyPaint = Paint()..color = Color(0xff6ab04c);
  }

  void render(Canvas c) {
    c.drawRect(flyRect, flyPaint);
  }

  void update(double t) {
    if (isDead) {
      flyRect = flyRect.translate(
          0, game.tileSize * 10 * t); //t=timeDelta; 10 = speed of falling;
    }
    if (flyRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
  }

  void onTapDown() {
    flyPaint..color = Colors.red;
    isDead = true;
    game.spawnFly();
  }
}
