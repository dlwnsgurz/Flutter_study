import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/models/quiz_question.dart';
import 'package:adv_basics/questions_screen.dart';
import 'package:adv_basics/result_screen.dart';
import 'package:adv_basics/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final List<String> selectedAnswers = [];
  var activeScreen = "start_screen";

  void switchScreen() {
    setState(() {
      activeScreen = "quiz_screen";
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    setState(() {
      if (selectedAnswers.length == questions.length) {
        activeScreen = 'result_screen';
      }
    });
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers.clear();
      activeScreen = 'start_screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget screenWidget;

    if (activeScreen == 'start_screen') {
      screenWidget = StartScreen(switchScreen);
    } else if (activeScreen == 'quiz_screen') {
      screenWidget = QuestionScreen(
        onSelectAnswer: chooseAnswer,
      );
    } else {
      screenWidget = ResultScreen(
        chosenAnswers: selectedAnswers,
        restart: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.deepPurple, Colors.purple],
              ),
            ),
            child: screenWidget),
      ),
    );
  }
}
