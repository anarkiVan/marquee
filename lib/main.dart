import 'package:flutter/material.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(10),
                controller: _scrollController,
                child: Container(
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                    softWrap: false,
                  ),
                ))),
      ),
    );
  }

  void _initAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      while (true) {
        await Future<dynamic>.delayed(Duration(seconds: 1));
        await _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.easeOutCubic);
        await Future<dynamic>.delayed(Duration(seconds: 1));
        await _scrollController.animateTo(
            _scrollController.position.minScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.easeOutCubic);
      }
    });
  }
}
