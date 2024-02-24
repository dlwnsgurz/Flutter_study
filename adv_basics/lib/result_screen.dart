import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/question_summary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key, required this.chosenAnswers, required this.restart});

  final List<String> chosenAnswers;
  final void Function() restart;

  List<Map<String, Object>> get summaryData {
    List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        "question_index": i,
        "question": questions[i].text,
        "correct_answer": questions[i].answers[0],
        "user_answer": chosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestion = questions.length;
    final numCorrectQuesion = summaryData
        .where(
          (data) => data["user_answer"] == data["correct_answer"],
        )
        .length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You Answer $numCorrectQuesion out of $numTotalQuestion questions correctly",
              style: GoogleFonts.aDLaMDisplay(
                color: Colors.white.withOpacity(0.8),
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            QuestionSummary(summaryData: summaryData),
            TextButton.icon(
                icon: const Icon(Icons.restart_alt_outlined),
                onPressed: restart,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                label: const Text("Restart Quiz")),
          ],
        ),
      ),
    );
  }
}
