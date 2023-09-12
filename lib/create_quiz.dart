// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizzle/home.dart';
import 'quiz.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final TextEditingController _c1 = TextEditingController();
  final TextEditingController _c2 = TextEditingController();
  final TextEditingController _c3 = TextEditingController();
  String quiztitle = "";
  String question = "";
  String fallback = "";
  bool? answer;
  List<Question> questionlist = [];
  List<DropdownMenuEntry<Question>> lst = [];

  Container myButton({
    required String? text,
    required Icon? icon,
    required Color? bgColor,
    required void Function()? onPress,
  }) {
    return Container(
      width: double.infinity,
      height: 100,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  ListTile(
                    leading: Text("Title"),
                    title: TextField(
                      onChanged: (value) {
                        setState(() {
                          quiztitle = value;
                        });
                      },
                      maxLines: 2,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  if (lst.isNotEmpty) SizedBox(height: 10),
                  if (lst.isNotEmpty)
                    DropdownMenu(
                      dropdownMenuEntries: lst,
                      label: const Text("Tap to delete questions"),
                      onSelected: (op) {
                        setState(() {
                          lst.removeWhere((element) => element.value == op!);
                          questionlist.removeWhere((element) => element == op!);
                        });
                      },
                    ),
                  Spacer(),
                  ListTile(
                    leading: Text("Question"),
                    title: TextField(
                      controller: _c1,
                      enabled: quiztitle.length > 3,
                      onChanged: (value) {
                        setState(() {
                          question = value;
                        });
                      },
                      maxLines: null,
                    ),
                  ),
                  Spacer(),
                  Row(children: [
                    const Text("Answer"),
                    DropdownMenu<bool>(
                      controller: _c2,
                      enabled: quiztitle.length > 3,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: true, label: "True"),
                        DropdownMenuEntry(value: false, label: "False"),
                      ],
                      onSelected: (v) {
                        setState(() {
                          answer = v;
                        });
                      },
                    )
                  ]),
                  Spacer(),
                  ListTile(
                    leading: Text("Correction statement"),
                    title: TextField(
                      controller: _c3,
                      enabled: quiztitle.length > 3,
                      onChanged: (value) {
                        fallback = value;
                      },
                      maxLines: null,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  (question.length > 10 && answer != null)
                      ? myButton(
                          text: "Add to Questions",
                          icon: Icon(Icons.add),
                          bgColor: Colors.green,
                          onPress: () {
                            setState(() {
                              pressed();
                            });
                          },
                        )
                      : const Text("Provide a Question and an Answer"),
                  // ignore: prefer_is_empty
                  questionlist.length > 0
                      ? myButton(
                          text: "Save Quiz",
                          icon: Icon(Icons.question_mark),
                          bgColor: Colors.black12,
                          onPress: () {
                            Quiz quiz =
                                Quiz(name: quiztitle, questions: questionlist);
                            var noc = Navigator.of(context);
                            quizList.add(quiz);
                            filtered = quizList;
                            noc.pop();
                            noc.pop();
                            noc.push(MaterialPageRoute(
                                builder: (context) => const HomePage()));
                          },
                        )
                      : const Text("Provide at least three questions"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void pressed() {
    Question qn = Question(question, answer!, fallback: fallback);
    questionlist.add(qn);
    lst.add(DropdownMenuEntry<Question>(
      value: qn,
      label: qn.content,
      trailingIcon: Icon(Icons.close, color: Colors.red),
    ));
    _c1.clear();
    _c2.clear();
    _c3.clear();
    question = "";
    answer = null;
    fallback = "";
  }
}
