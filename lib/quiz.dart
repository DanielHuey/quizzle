class Question {
  String content;
  bool answer;
  late String fallback;

  Question(this.content, this.answer, {String fallback = ""}) {
    if (fallback == "") {
      this.fallback = "The answer is $answer";
    } else {
      this.fallback = fallback;
    }
  }
}

class Quiz {
  String name;
  List<Question> questions;
  int quizScore = 0;
  Quiz({required this.name, required this.questions});
}

Quiz testQuiz = Quiz(
  name: "Test Quiz",
  questions: [
    Question("Are metals polymers?", true),
    Question("Did America land on the moon?", false,
        fallback: "It's Neil Armstrong, not America!"),
    Question("Uganda has only 4 classes in Secondary.", false),
    Question("Grass is gren", false, fallback: "Grass isn't GREN!"),
    Question(
        "People working at the calendar factory cannot take a day off.", true,
        fallback:
            "It's true because we would otherwise have no days on the calendar"),
  ],
);

List<Quiz> quizList = [
  testQuiz,
];
List<Quiz> filtered = quizList;
