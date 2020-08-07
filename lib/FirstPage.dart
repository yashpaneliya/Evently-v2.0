import 'package:flutter/cupertino.dart'
    show
        BorderRadius,
        BuildContext,
        Center,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        FontWeight,
        Navigator,
        RoundedRectangleBorder,
        State,
        StatefulWidget,
        Text,
        TextStyle,
        Widget;
import 'package:flutter/material.dart';
import 'package:meetup/attendee_login.dart';
import 'package:meetup/organizerlogin.dart';
import 'Animations/FadeAnimation.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return firststate();
  }
}

class firststate extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/back9.png'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FadeAnimation(
                1.8,
                Container(
                  width: 300,
                  padding: EdgeInsets.only(top: 230),
                  child: Text(
                    "Evently",
                    style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'R'),
                  ),
                ),
              ),
              FadeAnimation(
                1.8,
                Container(
                  width: 300,
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Share the events \nAttend the events\nBuild a huge community",
                    style: TextStyle(
                        fontSize: 18.0, color: Colors.white, fontFamily: 'R'),
                  ),
                ),
              ),
              FadeAnimation(
                  1.8,
                  Center(
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.only(top: 25),
                      child: Center(
                          child: MaterialButton(
                        color: Colors.white,
                        textColor: Colors.deepOrange,
                        elevation: 5.0,
                        minWidth: 200.0,
                        height: 50.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          attende();
                        },
                        child: Text(
                          'Attendee',
                          style: TextStyle(fontSize: 20.0, fontFamily: 'R'),
                        ),
                      )),
                    ),
                  )),
              FadeAnimation(
                  1.8,
                  Center(
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.all(25),
                      child: Center(
                          child: MaterialButton(
                        color: Colors.white,
                        textColor: Colors.deepOrange,
                        elevation: 5.0,
                        minWidth: 200,
                        height: 50.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          organier();
                        },
                        child: Text(
                          'Organization',
                          style: TextStyle(fontSize: 20.0, fontFamily: 'R'),
                        ),
                      )),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void attende() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return att_login();
    }));
  }

  void organier() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return org_login();
    }));
  }
}
