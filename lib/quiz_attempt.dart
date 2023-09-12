import 'package:flutter/material.dart';
import 'quiz.dart';

class QuizAttempt extends StatefulWidget {
  const QuizAttempt({super.key, required this.quiz});
  final Quiz quiz;
  @override
  State<QuizAttempt> createState() => _QuizAttemptState();
}

class _QuizAttemptState extends State<QuizAttempt> {
  late List<Question> questions;
  @override
  void initState() {
    super.initState();
    questions = widget.quiz.questions;
  }

  Container myButton({
    required String? text,
    required Icon? icon,
    required Color? bgColor,
    required void Function()? onPress,
  }) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: TextButton.icon(
        onPressed: onPress,
        style: ButtonStyle(
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          overlayColor: MaterialStatePropertyAll(bgColor?.withOpacity(0.75)),
          backgroundColor: MaterialStatePropertyAll(bgColor?.withOpacity(0.25)),
        ),
        icon: icon!,
        label: Text(text!, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  List<Icon> score = [];
  int index_ = 0;

  void onPress(bool? ans) {
    setState(() {
      if (index_ != questions.length) {
        if (ans! == questions[index_].answer) {
          score.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
          widget.quiz.quizScore++;
        } else {
          score.add(const Icon(
            Icons.clear,
            color: Colors.red,
          ));
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(questions[index_].fallback),
              showCloseIcon: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
          );
        }
        index_++;
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        // print("Restart it ");
        index_ = 0;
        score = []; //maybe show a restart button
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool neq = index_ != questions.length;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 13, 13),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 8,
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                    child: Text(
                      neq
                          ? questions[index_].content
                          : "Thanks for your participation.\nYou got ${widget.quiz.quizScore} out of ${questions.length}",
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
            Expanded(
              flex: 3,
              child: Column(
                children: neq
                    ? [
                        myButton(
                          text: "True",
                          icon: const Icon(Icons.check),
                          bgColor: Colors.greenAccent,
                          onPress: () => onPress(true),
                        ),
                        myButton(
                            text: "False",
                            icon: const Icon(Icons.clear),
                            bgColor: Colors.redAccent,
                            onPress: () => onPress(false)),
                      ]
                    : [
                        myButton(
                            text: "Take a coffee!",
                            icon: const Icon(Icons.coffee),
                            bgColor: Colors.yellowAccent,
                            onPress: () => onPress(null)),
                      ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                child: Row(
                  children: score,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
