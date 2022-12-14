import 'dart:async';
import 'dart:math';

import 'package:color_brain/result.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Brain',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<String> texts = [
  "あか", "みどり", "あお"
];

List<Color> colors = [
  Colors.red, Colors.green, Colors.blue
];

class _MyHomePageState extends State<MyHomePage> {
  late Color currentColor;
  late String currentText;
  List<bool> results = [];
  double answerRate = 0.0;
  late Stopwatch stopwatch;
  late Timer timer;
  double currentTimeSec = 0.0;
  final int numProblem = 25;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch()..start();
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        currentTimeSec = stopwatch.elapsedMilliseconds / 1000;
      });
    });
    updateProblem();
  }

  @override
  void dispose() {
    stopwatch.stop();
    timer.cancel();
    super.dispose();
  }

  void updateProblem() {
    currentColor = colors[Random().nextInt(3)];
    currentText = texts[Random().nextInt(3)];
  }

  void checkAnswer(Color guess) {
    if (currentColor == guess) {
      print("正解!");
      results.add(true);
    }
    else {
      print("不正解...");
      results.add(false);
    }
    answerRate = results.where((e) => e).length/results.length*100;
    if (results.length == numProblem) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => ResultPage(answerRate, currentTimeSec)));
    }
    else {
      setState(() {
        updateProblem();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("文字の色のボタンを押そう", style: TextStyle(fontSize: 30),),
            Text(
              "(${results.length + 1}/$numProblem)${currentTimeSec.toStringAsFixed(1).padLeft(5, "0")} sec",
              style: const TextStyle(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(currentText, style: TextStyle(color: currentColor, fontSize: 100),),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      checkAnswer(Colors.red);
                    },
                    child: const Text("Red"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      checkAnswer(Colors.green);
                    },
                    child: const Text("Green"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      checkAnswer(Colors.blue);
                    },
                    child: const Text("Blue"),
                  ),
                )
              ],
            ),
            Text("正答率: ${answerRate.toStringAsFixed(1)} % (${results.where((e) => e).length}/${results.length})")
          ],
        ),
      ),
    );
  }
}
