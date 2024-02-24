import 'package:flutter/material.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (data["correct_answer"] as String) ==
                              (data["user_answer"] as String)
                          ? Colors.blue
                          : Colors.red.shade400,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        ((data["question_index"] as int) + 1).toString(),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["question"] as String,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          data["correct_answer"] as String,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          data["user_answer"] as String,
                          style: TextStyle(
                              color: Colors.blueAccent.withOpacity(0.8),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
