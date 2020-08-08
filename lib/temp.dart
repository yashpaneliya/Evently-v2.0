import 'package:flutter/material.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 100.0, right: 10, left: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Container(
            height: 60,
            color: Colors.grey.shade200,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 10),
                  height: 40,
                  child: Icon(
                    Icons.school,
                    color: Colors.white,
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Instution name",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 0.0),
            child: Text(
              "name",
              style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 0.0),
            child: Text(
              "name",
              style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 0.0),
            child: Text(
              "name",
              style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      ),
    ));
  }
}
