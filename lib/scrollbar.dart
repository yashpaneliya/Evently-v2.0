import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meetup/FirstPage.dart';
import 'Animations/FadeAnimation.dart';
import 'authentication/auth.dart';
import 'authentication/auth_provider.dart';

final db = Firestore.instance;

class account_bar extends StatefulWidget {
  final VoidCallback onSignedOut;

  const account_bar({Key key, this.onSignedOut});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return account();
  }
}

class account extends State<account_bar> {
  
  String name, email, phone, surname;
  DocumentSnapshot snapshot;
  
  void getData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    print(uid);
    snapshot = await db.collection('users').document(uid).get();
    setState(() {
      name = snapshot.data['Name'];
      surname = snapshot.data['Surname'];
      email = snapshot.data['Email'];
      phone = snapshot.data['Number'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEFEA),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'R',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              _signOut(context);
              Route route =
                  MaterialPageRoute(builder: (context) => FirstPage());
              Navigator.pushReplacement(context, route);
            },
          )
        ],
      ),
      body: Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.17,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              border: Border.all(
                width: 1.0,
                color: Colors.deepOrange,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          child: Center(
            child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'From',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'PANDAVAS',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0,
                          fontSize: 18.0),
                    ),
                  ],
                )),
          ),
        ),
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25),
                FadeAnimation(
                  0.8,
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.26,
                      width: 180,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3.0, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(2, 2),
                              color: Colors.black,
                              blurRadius: 10.0)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                              Colors.deepOrangeAccent[10],
                              BlendMode.color,
                            ),
                            fit: BoxFit.fitWidth,
                            image: AssetImage('assets/id.jpg')),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                FadeAnimation(
                  1.0,
                  Container(
                    child: Text(
                      '$name  $surname'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'R',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: FadeAnimation(
                    1.0,
                    Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          title: Text(
                            '$email',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'R',
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                  ),
                ),
                FadeAnimation(
                  1.0,
                  Container(
                      // alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        title: Text(
                          '$phone',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'R',
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top:15.0),
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 1.0,
                  decoration: BoxDecoration(color: Colors.deepOrange),
                ),
                FadeAnimation(
                  1.0,
                  Container(
                    margin: EdgeInsets.only(top:15.0),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: Colors.black,
                        ),
                        title: Text(
                          'About Us',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'R',
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                FadeAnimation(
                  1.0,
                  Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ListTile(
                        leading: Icon(
                          Icons.feedback,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Give Feedback',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'R',
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                // MaterialButton(
                //   height: 45.0,
                //   minWidth: 300.0,
                //   // elevation: 10.0,
                //   color: Colors.deepOrange,
                //   textColor: Colors.white,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30.0)),
                //   child: Text(
                //     'Log out',
                //     style: TextStyle(fontSize: 18.0),
                //   ),
                //   onPressed: () {
                //     _signOut(context);
                //     Route route =
                //         MaterialPageRoute(builder: (context) => FirstPage());
                //     Navigator.pushReplacement(context, route);
                //   },
                // )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}

class eventpage extends StatefulWidget {
  @override
  event_page createState() => new event_page();
}

class event_page extends State<eventpage> {
  String appTitle = "AppBar Title";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //title: "My App 2019",
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          bottomOpacity: 0.5,
          title: Text('Event Details'),
          centerTitle: true,
        ),
        body: ClipPath(
          clipper: MyClip(),
          child: Container(
            height: 400,
            width: 500,
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Color(0xFF1D5D51),
                      BlendMode.color,
                    ),
                    fit: BoxFit.cover,
                    image: AssetImage('assets/id.jpg'))),
            alignment: new FractionalOffset(1.0, 0.5),
            child: Text(
              "shubham",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                //AlignPositioned(
              ),
            ),
          ),
        ),
      ),
      onWillPop: () {},
    );
  }
}

class MyClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(0, size.height);
    p.lineTo(size.width, size.height / 2);
    p.lineTo(size.width, 0);
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
