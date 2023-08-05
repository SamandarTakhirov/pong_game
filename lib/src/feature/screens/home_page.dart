import 'package:flutter/material.dart';

import 'game_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image(
              image: const AssetImage("assets/images/bkg.png"),
              fit: BoxFit.cover,
              width: size.width,
            ),
          ),
          Column(
            children: [

              size.width < 500 ? SizedBox(height: 150): SizedBox(),
              Text(
                "Pong Game",
                style: TextStyle(
                  fontSize: size.width <500 ? size.width * 0.1 : size.width * 0.08,
                  fontWeight: FontWeight.w900,
                  color: Colors.blue,
                ),
              ),
              size.width < 500 ? SizedBox(height: 150): SizedBox(height: 150),
              Center(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    elevation: 5,
                    fixedSize: Size(size.width < 500 ? size.width * 0.5 : size.width * 0.2, size.height * 0.08),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Tap to start game",
                    style: TextStyle(
                      fontSize: size.width < 500 ? size.width * 0.05 : size.width * 0.02,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
