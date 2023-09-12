import 'package:flutter/material.dart';
import 'create_quiz.dart';
import 'quiz.dart';
import 'quiz_attempt.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = "";
  void filterList() {
    setState(() {
      if (search != "") {
        filtered = [];
        for (int i = 0; i < quizList.length; i++) {
          var lowerCase = quizList[i].name.toLowerCase();
          if (lowerCase.contains(RegExp(search, caseSensitive: false))) {
            filtered.add(quizList[i]);
          } else {
            List<String> split = search.split(' ');
            bool add = false;
            for (var s in split) {
              if (lowerCase.contains(RegExp(s, caseSensitive: false))) {
                add = true;
              } else {
                add = false;
              }
              if (!add) {
                break;
              }
            }
            if (add) {
              filtered.add(quizList[i]);
            }
          }
        }
      } else {
        filtered = quizList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 13, 13),
      appBar: AppBar(
        toolbarHeight: 140,
        actions: [
          IconButton(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Quizzle",
                  applicationVersion: "1.0",
                  applicationLegalese: "GNU GPL",
                  applicationIcon: Image.asset('assets/hot_mug.png'),
                );
              },
              icon: const Icon(Icons.info))
        ],
        toolbarOpacity: 0.9,
        title: Column(
          children: [
            const Text("Quizzle"),
            SearchBar(
              hintText: "Search for a quiz...",
              leading: const Icon(Icons.search),
              onChanged: ((value) {
                search = value;
                filterList();
              }),
              elevation: const MaterialStatePropertyAll(0.25),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const CreateQuiz()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text("Create a new quiz"),
                    ));
              });
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: filtered.length,
        // prototypeItem: const Padding(
        //   padding: EdgeInsets.all(16.0),
        //   child: ListTile(
        //     shape: StadiumBorder(),
        //     leading: Text("txt"),
        //     title: Text("filtered[index].name"),
        //   ),
        // ),
        itemBuilder: ((context, index) {
          bool fav = false;
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              tileColor: Colors.amber.shade100.withOpacity(0.25),
              leading: StatefulBuilder(
                builder: (ctx, setState) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        fav = !fav;
                      });
                    },
                    icon: Icon(
                      fav ? Icons.star : Icons.star_border,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              title: Text(
                filtered[index].name,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                filtered[index].quizScore = 0;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QuizAttempt(quiz: filtered[index]),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
