import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: quizapp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class quizapp extends StatefulWidget {
  const quizapp({super.key});
  @override
  State createState() => _quizappstate();
}

class _quizappstate extends State {
  bool questionscreen = true;
  int questionindex = 0;
  int selectedanswerIndex = -1;
  int noOfCorrectans = 0;

  List<Map> allquestions = [
    {
      "questions": "Who is the founder of microsoft",
      "options": ["Steve Jobs", "Jeff Bezoz", "Bill gates", "Elon Musk"],
      "answerIndex": 2,
    },
    {
      "questions": "Who is the founder of apple",
      "options": ["Steve Jobs", "Jeff Bezoz", "Bill gates", "Elon Musk"],
      "answerIndex": 0,
    },
    {
      "questions": "Who is the founder of Amazon",
      "options": ["Steve Jobs", "Jeff Bezoz", "Bill gates", "Elon Musk"],
      "answerIndex": 1,
    },
    {
      "questions": "Who is the founder of Tesla",
      "options": ["Steve Jobs", "Jeff Bezoz", "Bill gates", "Elon Musk"],
      "answerIndex": 3,
    },
    {
      "questions": "Who is the founder of Google",
      "options": ["Steve Jobs", "Larry Page", "Bill gates", "Elon Musk"],
      "answerIndex": 1,
    }
  ];

  MaterialStateProperty<Color>? checkanswer(int buttonIndex) {
    if (selectedanswerIndex != -1) {
      if (buttonIndex == allquestions[questionindex]["answerIndex"]) {
        return const MaterialStatePropertyAll(Colors.green);
      } else if (buttonIndex == selectedanswerIndex) {
        return const MaterialStatePropertyAll(Colors.red);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  void validateCurrentPage() {
    if (selectedanswerIndex == -1) {
      return;
    }

    if (selectedanswerIndex == allquestions[questionindex]["answerIndex"]) {
      noOfCorrectans += 1;
    }
    if (selectedanswerIndex != -1) {
      if (questionindex == allquestions.length - 1) {
        setState(() {
          questionscreen = false;
        });
      }
      selectedanswerIndex = -1;
      setState(() {
        questionindex += 1;
      });
    }
  }

  Scaffold isQuestionScreen() {
    if (questionscreen == true) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quiz App",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.orange),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Question :",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${questionindex + 1}/${allquestions.length}",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 380,
              height: 50,
              child: Text(
                allquestions[questionindex]["questions"],
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  if (selectedanswerIndex == -1) {
                    setState(() {
                      selectedanswerIndex = 0;
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: checkanswer(0),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(30))),
                  minimumSize: MaterialStatePropertyAll(
                    Size(200, 30),
                  ),
                ),
                child: Text(
                  "A.${allquestions[questionindex]["options"][0]}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.normal),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (selectedanswerIndex == -1) {
                    setState(() {
                      selectedanswerIndex = 1;
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: checkanswer(1),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(30))),
                  minimumSize: MaterialStatePropertyAll(
                    Size(200, 30),
                  ),
                ),
                child: Text(
                  "B.${allquestions[questionindex]["options"][1]}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.normal),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (selectedanswerIndex == -1) {
                      setState(() {
                        selectedanswerIndex = 2;
                      });
                    }
                  });
                },
                style: ButtonStyle(
                  backgroundColor: checkanswer(2),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(30),
                    ),
                  ),
                  minimumSize: MaterialStatePropertyAll(
                    Size(200, 30),
                  ),
                ),
                child: Text(
                  "C.${allquestions[questionindex]["options"][2]}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.normal),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (selectedanswerIndex == -1) {
                      setState(() {
                        selectedanswerIndex = 3;
                      });
                    }
                  });
                },
                style: ButtonStyle(
                    backgroundColor: checkanswer(3),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(30))),
                    minimumSize: MaterialStatePropertyAll(Size(200, 30))),
                child: Text(
                  "D.${allquestions[questionindex]["options"][3]}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.normal),
                )),
            const SizedBox(height: 20)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            validateCurrentPage();
          },
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.forward,
            color: Colors.orange,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Result")),
        body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Congratulations on Completing the Quiz"),
              SizedBox(
                height: 20,
              ),
              Text("$noOfCorrectans/${allquestions.length}"),
              ElevatedButton(
                  onPressed: () {
                    questionindex = 0;
                    questionscreen = true;
                    noOfCorrectans = 0;
                    selectedanswerIndex = -1;
                    setState(() {});
                  },
                  child: Text("Reset"))
            ],
          ),
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isQuestionScreen();
  }
}
