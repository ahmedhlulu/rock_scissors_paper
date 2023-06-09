import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const Game());

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  void initState() {
    super.initState();
    leftPic = Random().nextInt(3) + 1;
    rightPic = Random().nextInt(3) + 1;
  }

  late int leftPic;
  late int rightPic;
  int score = 0;
  int games = 0;

  double animatedScaleTop = 0;

  double animatedTurnsTop = 0;
  Duration animatedTurnsDurationTop = const Duration(seconds: 2);

  double animatedScale = 1;
  Duration animatedScaleDuration = const Duration(seconds: 0);
  Duration animatedScaleDurationTimer = const Duration(seconds: 1);


  void play() {
    setState(() {
      animatedScale = 0;
      animatedScaleTop = 1;
      animatedTurnsTop += 4;

      leftPic = Random().nextInt(3) + 1;
      rightPic = Random().nextInt(3) + 1;
      if (leftPic == rightPic) {
        if (rightPic != 3) {
          rightPic++;
        } else {
          rightPic--;
        }
      }
    });

    Timer(animatedScaleDurationTimer, () {
      setState(() {
        animatedScale = 1;
        animatedScaleTop = 0;
      });
    });

    score += winner() ? 1 : 0;
    games++;
  }

  bool winner(){
    if (leftPic == 1 && rightPic == 2) {
      return false;
    } else if (leftPic == 1 && rightPic == 3) {
      return true;
    } else if (leftPic == 2 && rightPic == 1) {
      return true;
    } else if (leftPic == 2 && rightPic == 3) {
      return false;
    } else if (leftPic == 3 && rightPic == 1) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue.shade900,
        appBar: AppBar(
          title: const Text('Rock Scissors Paper'),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24),
              height: 100,
              child: AnimatedRotation(
                turns: animatedTurnsTop,
                duration: animatedTurnsDurationTop,
                child: AnimatedScale(
                  scale: animatedScaleTop,
                  duration: animatedScaleDuration,
                  child: Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("images/hand1.png",height: 50,width: 50),
                            const SizedBox(width: 15),
                            Image.asset("images/hand2.png",height: 50,width: 50),
                          ],
                        ),
                        Image.asset("images/hand3.png",height: 50,width: 50)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: animatedScale,
                  duration: animatedScaleDuration,
                  child: Column(
                    children: [
                      Text(
                        winner() ? "You Win 🥳🥳" : "You Los",
                        style: TextStyle(fontSize: 24, color: winner() ? Colors.greenAccent : Colors.redAccent),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: play,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/hand$leftPic.png"),
                                  Text(
                                    "You",
                                    style: TextStyle(fontSize: 24, color: winner() ? Colors.greenAccent : Colors.pink),
                                  ),
                                  // Text(
                                  //   "$score",
                                  //   style: TextStyle(fontSize: 24, color: score > games - score ? Colors.greenAccent : Colors.pink),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          const Text(
                            "VS",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/hand$rightPic.png"),
                                  Text(
                                    "System",
                                    style: TextStyle(fontSize: 24, color: !winner() ? Colors.greenAccent : Colors.pink),
                                  ),
                                  // Text(
                                  //   "${games - score}",
                                  //   style: TextStyle(fontSize: 24, color: score < games - score ? Colors.greenAccent : Colors.pink),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
