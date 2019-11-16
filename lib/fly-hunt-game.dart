import 'dart:ui';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'components/fly.dart';

class FlyHuntGame extends Game {
  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;

  FlyHuntGame() {
    initialize();
  }

  void initialize() async {
    //flies = List<Fly>();
    flies = [];
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    spawnFly();
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);
    flies.add(Fly(this, x, y));
  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint()..color = Colors.blueGrey;
//    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);
    flies.forEach((Fly fly) => fly.render(canvas));
  }

  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    flies.forEach((Fly fly) {
      if (fly.flyRect.contains(d.globalPosition)) {
        fly.onTapDown();
      }
    });
  }
}
