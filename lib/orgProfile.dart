import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';

String name = ' ';
String email = ' ';
String number = ' ';
final db = Firestore.instance;
String length = ' ';
QuerySnapshot qn;
List<DocumentSnapshot> list;

class orgProfile extends StatefulWidget {
  @override
  _orgProfileState createState() => _orgProfileState();
}

class _orgProfileState extends State<orgProfile> {
  DocumentSnapshot snapshot;
  QuerySnapshot snap2;
  bool _dark = false;
  void getData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    print(uid);
    snapshot = await db.collection('organizer').document(uid).get();
    qn = await Firestore.instance
        .collection('organizer')
        .document(uid)
        .collection('events')
        .getDocuments();
    setState(() {
      name = snapshot.data['name'];
      email = snapshot.data['email'];
      number = snapshot.data['number'];
      list = qn.documents;
      length = list.length.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dark=false;
    getData();
  }
  bool visibilityicon = false;
  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: (_dark ? null : Colors.white),
        body: Container(
          color: (_dark ? null : Colors.white),
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30.0,),
              Center(
                child: Stack(
                  children: <Widget>[
                    CircularText(
                      children: [
                        TextItem(
                          text: Text(
                            "Events".toUpperCase(),
                            style: TextStyle(
                              fontSize: 35.0,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          space: 17,
                          startAngle: -90,
                          startAngleAlignment: StartAngleAlignment.center,
                          direction: CircularTextDirection.clockwise,
                        ),
                        TextItem(
                          text: Text(
                            "organized".toUpperCase(),
                            style: TextStyle(
                              fontSize: 35.0,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          space: 19,
                          startAngle: 90,
                          startAngleAlignment: StartAngleAlignment.center,
                          direction: CircularTextDirection.anticlockwise,
                        ),
                      ],
                      radius: 105,
                      position: CircularTextPosition.inside,
                      backgroundPaint: Paint()..color = Colors.grey.shade200,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 75.0, left: 90.0),
                      child: Text('$length',
                          style: TextStyle(
                            fontSize: 65.0,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.0,),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                height: 65,
                width: MediaQuery.of(context).size.width,
                color: (_dark ? null : Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        shape: BoxShape.circle,
                        color: (_dark ? Colors.black : Colors.white),
                        boxShadow: [
                          new BoxShadow(
                            color: (_dark ? Colors.white : Colors.black38),
                            blurRadius: 7.0,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(right: 2),
                      child: Icon(
                        Icons.business,
                        color: Colors.deepOrangeAccent,
                        size: 35,
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 30.0, right: 0, top: 0, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 0.0, right: 0, top: 10, bottom: 3),
                              decoration: BoxDecoration(),
                              child: Text(
                                "Organization",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 00.0, right: 0, top: 0, bottom: 10),
                              child: Text(
                                "$name",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color:
                                  (_dark ? Colors.white : Colors.black87),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: (_dark ? null : Colors.white),
                      ),
                      child: visibilityicon
                          ? MaterialButton(
                        onPressed: () {
                          setState(() {
                            visibilityicon = !visibilityicon;
                          });
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 30,
                        ),
                      )
                          : SizedBox(
                        height: 0.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                height: 65,
                width: MediaQuery.of(context).size.width,
                color: (_dark ? null : Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        shape: BoxShape.circle,
                        color: (_dark ? Colors.black : Colors.white),
                        boxShadow: [
                          new BoxShadow(
                            color: (_dark ? Colors.white : Colors.black38),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(right: 0),
                      child: Icon(
                        Icons.contact_mail,
                        color: Colors.deepOrangeAccent,
                        size: 30,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 30.0, right: 0, top: 0, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 0.0, right: 0, top: 10, bottom: 3),
                            margin: EdgeInsets.all(0),
                            decoration: BoxDecoration(),
                            child: Text(
                              "E-Mail",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 00.0, right: 0, top: 0, bottom: 10),
                            margin: EdgeInsets.all(0),
                            child: Text(
                              "$email",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: (_dark ? Colors.white : Colors.black87),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: (_dark ? null : Colors.white),
                      ),
                      child: visibilityicon
                          ? MaterialButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 30,
                        ),
                      )
                          : SizedBox(
                        height: 0.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                height: 65,
                width: MediaQuery.of(context).size.width,
                color: (_dark ? null : Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: (_dark ? Colors.white : Colors.white),
                        ),
                        shape: BoxShape.circle,
                        color: (_dark ? Colors.black : Colors.white),
                        boxShadow: [
                          new BoxShadow(
                            color: (_dark ? Colors.white : Colors.black38),
                            blurRadius: 7.0,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(right: 0),
                      child: Icon(
                        Icons.phone_iphone,
                        color: Colors.deepOrangeAccent,
                        size: 35,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 30.0, right: 0, top: 0, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 0.0, right: 0, top: 10, bottom: 3),
                            margin: EdgeInsets.all(0),
                            decoration: BoxDecoration(),
                            child: Text(
                              "Phone",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 00.0, right: 0, top: 0, bottom: 10),
                            margin: EdgeInsets.all(0),
                            child: Text(
                              "$number",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: (_dark ? Colors.white : Colors.black87),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 55,
                      height: 55,
//                      padding: EdgeInsets.only(left: 100),
                      decoration: BoxDecoration(
                        color: (_dark ? null : Colors.white),
                      ),
                      child: visibilityicon
                          ? MaterialButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 30,
                        ),
                      )
                          : SizedBox(
                        height: 0.0,
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
