import 'package:flutter/material.dart';

import 'package:calculator/component/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 808),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String questionUser = "";
  String answerUser = "";

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "*",
    "6",
    "5",
    "4",
    "+",
    "3",
    "2",
    "1",
    "-",
    "0",
    ".",
    "ANS",
    "=",
  ];

  bool checkIsOperator(String text) {
    if (text == "%" ||
        text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "=") {
      return true;
    }
    return false;
  }

  void enterToQuestionUser(String text) {
    setState(() {
      questionUser += text;
    });
  }

  void deleteAllQuestionUser() {
    setState(() {
      questionUser = "";
      answerUser = "";
    });
  }

  void deleteOneFromQuestionUser() {
    setState(() {
      questionUser = questionUser.substring(0, questionUser.length - 1);
    });
  }

  void equalPressed() {
    String finalQuestion = questionUser;
    Parser parser = Parser();
    Expression expression = parser.parse(finalQuestion);
    ContextModel contextModel = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, contextModel);
    setState(() {
      answerUser = eval.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 254, 229, 1),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      questionUser,
                      style: const TextStyle(
                        color: Colors.pink,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      answerUser,
                      style: const TextStyle(
                        color: Colors.pink,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Button(
                        buttonText: buttons[index],
                        buttonBGColor: const Color.fromRGBO(255, 204, 229, 0.6),
                        buttonTextColor: Colors.deepOrange,
                        buttonTapped: deleteAllQuestionUser,
                      );
                    } else if (index == 1) {
                      return Button(
                        buttonText: buttons[index],
                        buttonBGColor: const Color.fromRGBO(255, 204, 229, 0.6),
                        buttonTextColor: Colors.green,
                        buttonTapped: deleteOneFromQuestionUser,
                      );
                    } else if (index == buttons.length - 1) {
                      return Button(
                        buttonText: buttons[index],
                        buttonBGColor: Colors.pink,
                        buttonTextColor: Colors.white,
                        buttonTapped: equalPressed,
                      );
                    } else {
                      return Button(
                        buttonText: buttons[index],
                        buttonBGColor: checkIsOperator(buttons[index])
                            ? Colors.pink
                            : const Color.fromRGBO(255, 204, 229, 0.6),
                        buttonTextColor: checkIsOperator(buttons[index])
                            ? Colors.white
                            : Colors.pink,
                        buttonTapped: () => enterToQuestionUser(buttons[index]),
                      );
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
