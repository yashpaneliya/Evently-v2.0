import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  double _diameterRatio = 2;
  double _offAxisFraction = 0;
  double _magnification = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListWheelScrollView demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 600,
              child: ListWheelScrollView(
                useMagnifier: _magnification > 1000,
                magnification: _magnification,
                diameterRatio: _diameterRatio,
                offAxisFraction: _offAxisFraction,
                itemExtent: 50,
                children: <Widget>[
                  for (int i = 0; i < 20; i++) MyItem(index: i + 1)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyItem extends StatelessWidget {
  final int index;

  MyItem({@required this.index, Key key}) : super(key: key);

  static const colors = [
    Colors.pink,
    Colors.indigo,
    Colors.grey,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: 300,
        color: Colors.deepOrange,
        child: Text("Shubham"),
      ),
    );
  }
}
