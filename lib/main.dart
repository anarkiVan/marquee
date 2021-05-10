import 'package:flutter/material.dart';
import './widgets/marquee.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Ticker'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final String animatedText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Marqee(
              text: animatedText,
              animationDuration: Duration(seconds: 5),
              animationDelay: Duration(seconds: 1),
            )),
      ),
    );
  }
}
