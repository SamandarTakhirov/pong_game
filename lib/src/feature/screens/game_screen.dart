import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/game_painter.dart';
import '../widgets/pong_menu.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final double racketBottomOffset = 180.0;
  final double racketHeight = 30.0;
  final double racketWidth = 120.0;
  final double initialBallSpeed = 5.0;
  final double ballSize = 30;
  late Ticker ticker;

  double ballSpeedMultiplier = 2.5;
  double ballSpeedY = 0;
  double ballSpeedX = 0;
  double racketX = 20;
  double ballX = 0;
  double ballY = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    final random = Random();
    ballX = 0;
    ballY = 0;
    ballSpeedX = initialBallSpeed;
    ballSpeedY = initialBallSpeed;
    racketX = 100;
    score = 0;

    if (random.nextBool()) ballSpeedX = -ballSpeedX;
    if (random.nextBool()) ballSpeedY = -ballSpeedY;

    continueGame();
  }

  @override
  void dispose() {
    stopGame();
    super.dispose();
  }

  void stopGame() {
    ticker.dispose();
  }

  void continueGame() {
    Future.delayed(const Duration(seconds: 1), () {
      ticker = Ticker((elapsed) {
        setState(() {
          moveBall(ballSpeedMultiplier);
        });
      });
      ticker.start();
    });
  }

  void moveBall(double ballSpeedMultiplier) {
    ballX += ballSpeedX * ballSpeedMultiplier;
    ballY += ballSpeedY * ballSpeedMultiplier;
    final Size size = MediaQuery.sizeOf(context);

    if (ballY < 0) {
      ballSpeedY = -ballSpeedY;
      setState(() {
        score++;
        ballSpeedMultiplier = ballSpeedMultiplier * 1.1;
      });
    }

    if (ballX < 0 || ballX > size.width - ballSize) {
      ballSpeedX = -ballSpeedX;
    }

    if (ballY > size.height - ballSize - racketHeight - racketBottomOffset &&
        ballX >= racketX &&
        ballX <= racketX + racketWidth) {
      ballSpeedY = -ballSpeedY;
    } else if (ballY > size.height - ballSize) {
      stopGame();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PongMenu(
            subTitle: "Your score is: $score",
            title: "Game Over",
            child: CupertinoButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.pop(context);
                startGame();
              },
              child: const Text("Play Again"),
            ),
          );
        },
      );
    }
  }

  void moveRect(double dx) {
    setState(() {
      racketX = dx - racketWidth / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image(
              image: const AssetImage("assets/images/bkg1.png"),
              width: size.width,
              height: 190,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              moveRect(details.globalPosition.dx);
            },
            child: CustomPaint(
              painter: GamePainter(
                rackedHeight: racketHeight,
                rackedWidth: racketWidth,
                rackedX: racketX,
                racketBottomOffset: racketBottomOffset,
                ballY: ballY,
                ballSize: ballSize,
                ballX: ballX,
              ),
              size: Size.infinite,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: Text(
              "Score: $score",
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            right: 20,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                CupertinoIcons.pause,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: () {
                stopGame();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PongMenu(
                      subTitle: "Your score $score",
                      title: "Pause Game",
                      child: CupertinoButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          Navigator.pop(context);
                          continueGame();
                        },
                        child: const Text("Continue"),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
