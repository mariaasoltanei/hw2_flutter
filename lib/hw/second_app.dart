import 'package:flutter/material.dart';

void main() {
  runApp(SecondApp());
}

class SecondApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NumberShapesApp(),
    );
  }
}

class NumberShapesApp extends StatefulWidget {
  const NumberShapesApp({Key? key}) : super(key: key);

  HomePage createState() => HomePage();
}

class HomePage extends State<NumberShapesApp> {
  final numberController = TextEditingController();
  String resultText = '';

    showAlertDialog(BuildContext context) {
      Widget resetButton = TextButton(
        child: Text("OK"),
        onPressed:  () {
          Navigator.of(context).pop();
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("${numberController.text}"),
        content: Text("${resultText}"),
        actions: [
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

  bool isSquare(int number){
      int square = 0;
      for(int i = 0; i <= number / 2; i++){
        square = i*i;
        if(number == square)
          return true;
      }
      return false;
    }
  bool isCube(int number){
      int cube = 0;
      for(int i = 0; i <= number / 3; i++){
        cube = i * i * i;
        if (number == cube)
          return true;
      }
      return false;
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Number Shapes",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Please input a number to see if it is a perfect square or a perfect cube.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: numberController,
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                ),
              ),
            ],
          ),

        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            if(isCube(int.parse(numberController.text)) && isSquare(int.parse(numberController.text)))
              resultText = "The number ${numberController.text} is a perfect square and a perfect cube.";
            else if(isCube(int.parse(numberController.text)))
              resultText = "The number ${numberController.text} is a perfect cube.";
            else if(isSquare(int.parse(numberController.text)))
              resultText = "The number ${numberController.text} is a perfect square.";
            else if(!isCube(int.parse(numberController.text)) && !isSquare(int.parse(numberController.text)))
              resultText = "The number ${numberController.text} is neither a perfect square nor a perfect cube.";
            showAlertDialog(context);
          },
          child: Icon(Icons.check),
        ),

      );
    }
  }

