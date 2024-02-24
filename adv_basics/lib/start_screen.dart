import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/quiz-logo.png",
            color: Colors.white.withOpacity(0.8),
            width: 300,
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Learn Flutter the fun way!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.arrow_right_alt,
              color: Colors.white,
            ),
            onPressed: startQuiz,
            label: const Text(
              "Start Quiz",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
