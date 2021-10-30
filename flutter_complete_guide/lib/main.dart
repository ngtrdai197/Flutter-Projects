import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import 'package:flutter_complete_guide/question.dart';

void main() => runApp(MyApp());

class _MyAppState extends State<MyApp> {
  int questionSelected = 0;
  final questions = const [
    {
      "questionText": "What\'s your name ?",
      "answers": ["Huy", "Duyen", "Dai", "Loc"]
    },
    {
      "questionText": "How old are you ?",
      "answers": ["30", "27", "24", "21"]
    },
  ];

  void handlOnPress() {
    setState(() {
      if (questionSelected < questions.length - 1) {
        questionSelected++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Flutter Course'),
            ),
            body: Container(
              child: Column(
                children: [
                  Question(
                    questionText: questions[questionSelected]['questionText'],
                  ),
                  ...(questions[questionSelected]['answers'] as List<String>)
                      .map((answer) =>
                          Answer(btnName: answer, handlerCb: handlOnPress))
                      .toList()
                ],
              ),
            )));
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}
