// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, sized_box_for_whitespace
import 'dart:math';
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

  @override
  void initState() {
    super.initState();
    updateProblem();
  }

  void updateProblem() {
    currentColor = colors[Random().nextInt(3)];
    currentText = texts[Random().nextInt(3)];
  }

  void checkAnswer(Color guess) {
    if (currentColor == guess) {
      print("正解!");
    }
    else {
      print("不正解...");
    }
    setState(() {
      updateProblem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("文字の色のボタンを押そう", style: TextStyle(fontSize: 30),),
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
                    child: Text("Red"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      checkAnswer(Colors.green);
                    },
                    child: Text("Green"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      checkAnswer(Colors.blue);
                    },
                    child: Text("Blue"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
