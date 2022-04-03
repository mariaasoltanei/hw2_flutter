import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(FirstApp());
}

class FirstApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GuessNumberApp(),
    );
  }
}

class GuessNumberApp extends StatefulWidget {
const GuessNumberApp({Key? key}) : super(key: key);

HomePage createState() => HomePage();
}

class HomePage extends State<GuessNumberApp> {
  final numberController = TextEditingController();
  String guessAdvice = '';
  int number = Random().nextInt(100) + 1;
  bool showButton = true;


  showAlertDialog(BuildContext context) {
    Widget tryAgain = TextButton(
      child: Text("Try again!"),
      onPressed:  () {
      setState(() {
        numberController.text = '';
        guessAdvice = '';
        Navigator.of(context).pop();
      });
      number = Random().nextInt(100) + 1;
      },
    );
    Widget resetButton = TextButton(
      child: Text("OK"),
      onPressed:  () {
        setState(() {
          showButton = false;
        });
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("You guessed right"),
      content: Text("It was ${numberController.text}!"),
      actions: [
        tryAgain,
        resetButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget guessButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.greenAccent,
      ),
      onPressed: () {
        print(number);
        if(int.parse(numberController.text) == number)
          setState(() {
            guessAdvice = "Right guess!";
            showAlertDialog(context);
          });
        else if (int.parse(numberController.text) > number)
          setState(() {
            guessAdvice = "You entered ${numberController.text}. Try lower.";
          });
        else if (int.parse(numberController.text) < number)
          setState(() {
            guessAdvice = "You entered ${numberController.text}. Try higher.";
          });
        numberController.clear();
      },
      child:  Text(
        'Guess',
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }

  Widget resetButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.greenAccent,
      ),
      onPressed: () {
        setState(() {
          numberController.text = '';
          guessAdvice = '';
          showButton = true;
        });
        number = Random().nextInt(100) + 1;
      },
      child:  Text(
        'Reset',
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Guess my number",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
        ),
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
        ),
        body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "I'm thinking of a number between 1 and 100.",
                    style: TextStyle(
                      fontSize: 27,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "It's your turn to guess my number!",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      guessAdvice,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 250,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Try a number!",
                          style: TextStyle(
                            fontSize: 18
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TextField(
                        controller: numberController,
                        keyboardType: TextInputType.numberWithOptions(decimal: false),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: showButton ? guessButton() : resetButton()
                      ),
                    ],
                  )
                )
              ],

    ),

    )
    );
  }

}