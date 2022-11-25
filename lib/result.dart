import 'package:color_brain/main.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage(this.answerRate, this.timeSecond, {Key? key}) : super(key: key);
  final double answerRate;
  final double timeSecond;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("結果...", style: TextStyle(fontSize: 30),),
            Text("正答率: ${answerRate.toStringAsFixed(1)} %", style: const TextStyle(fontSize: 30),),
            Text("時間　: ${timeSecond.toStringAsFixed(1)} s", style: const TextStyle(fontSize: 30),),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const MyHomePage()));
            }, child: const Text("もう一度遊ぶ"))
          ],
        ),
      ),
    );
  }
}
