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

  void play() {
    setState(() {
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

    bool winner = true;
    if (leftPic == 1 && rightPic == 2) {
      winner = false;
    } else if (leftPic == 1 && rightPic == 3) {
      winner = true;
    } else if (leftPic == 2 && rightPic == 1) {
      winner = true;
    } else if (leftPic == 2 && rightPic == 3) {
      winner = false;
    } else if (leftPic == 3 && rightPic == 1) {
      winner = false;
    } else {
      winner = true;
    }
    score += winner ? 1 : 0;
    games++;
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "game no: $games",
              style: const TextStyle(fontSize: 24, color: Colors.white),
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
                          style: TextStyle(fontSize: 24, color: score > games - score ? Colors.greenAccent : Colors.pink),
                        ),
                        Text(
                          "$score",
                          style: TextStyle(fontSize: 24, color: score > games - score ? Colors.greenAccent : Colors.pink),
                        ),
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
                          style: TextStyle(fontSize: 24, color: score < games - score ? Colors.greenAccent : Colors.pink),
                        ),
                        Text(
                          "${games - score}",
                          style: TextStyle(fontSize: 24, color: score < games - score ? Colors.greenAccent : Colors.pink),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
