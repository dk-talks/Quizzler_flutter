import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Quizzler(),
        backgroundColor: Colors.black,
      ),
    );
  }
}

void main() => runApp(MyApp());

class Quizzler extends StatefulWidget {
  const Quizzler({super.key});

  @override
  State<Quizzler> createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  bool isQuizFinished = false;
  int currentQuestion = 0;
  List<Icon> feedbacks = [];
  QuizBrain quizBrain = QuizBrain();

  Icon tickMark() {
    return const Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  Icon crossMark() {
    return const Icon(
      Icons.clear,
      color: Colors.red,
    );
  }

  void showAlert() {
    setState(() {
      Alert(
        context: context,
        type: AlertType.info,
        title: "Quiz Finished",
        desc: "This Quiz will reset Now, Keep Learning!",
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            width: 120,
            child: const Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 7,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                quizBrain.getQuestion(currentQuestion),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: FilledButton(
              onPressed: () {
                if (quizBrain.isQuizFinished(currentQuestion)) {
                  showAlert();
                  currentQuestion = 0;
                  feedbacks = [];
                  return;
                }
                setState(() {
                  if (quizBrain.checkAnswer(currentQuestion, true)) {
                    feedbacks.add(tickMark());
                    currentQuestion++;
                  } else {
                    feedbacks.add(crossMark());
                    currentQuestion++;
                  }
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(LinearBorder.none),
              ),
              child: const Text('True'),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: FilledButton(
              onPressed: () {
                if (quizBrain.isQuizFinished(currentQuestion)) {
                  showAlert();
                  currentQuestion = 0;
                  feedbacks = [];
                  return;
                }
                setState(() {
                  if (quizBrain.checkAnswer(currentQuestion, false)) {
                    feedbacks.add(tickMark());
                    currentQuestion++;
                  } else {
                    feedbacks.add(crossMark());
                    currentQuestion++;
                  }
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(LinearBorder.none),
              ),
              child: Text('False'),
            ),
          ),
        ),
        Row(
          children: feedbacks,
        ),
      ],
    );
  }
}
