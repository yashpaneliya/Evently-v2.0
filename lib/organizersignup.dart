import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meetup/organier.dart';
import 'package:meetup/organizers.dart';
import 'Animations/FadeAnimation.dart';

class org_signup extends StatefulWidget {
  final VoidCallback onSignedIn;

  const org_signup({this.onSignedIn});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return organizersignup();
  }
}

class organizersignup extends State<org_signup> {
  final GlobalKey<FormState> fkey = GlobalKey<FormState>();
  String email, password, name, number;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var passwordshow = true;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.deepOrange,
        body: Form(
            key: fkey,
            child: Container(
              margin: EdgeInsets.only(top: 50.0),
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: ListView(
                children: <Widget>[
                  FadeAnimation(
                    1.0,
                    Container(
                      padding: EdgeInsets.only(left: 0.0, right: 30.0),
                      child: Text(
                        "Organizer Sign Up",
                        style: TextStyle(
                            fontSize: 50.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'R'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  FadeAnimation(
                      1.5,
                      Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.deepOrange[300]))),
                              child: Row(children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(.8),
                                            fontFamily: 'R'),
                                        hintText: "Organization Name"),
                                    onChanged: (input) => name = input,
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.deepOrange[300]))),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(.8),
                                        fontFamily: 'R'),
                                    hintText: "Email"),
                                onChanged: (input) => email = input,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.deepOrange[300]))),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(.8),
                                        fontFamily: 'R'),
                                    hintText: "Contact number"),
                                keyboardType: TextInputType.number,
                                onChanged: (input) => number = input,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.deepOrange[300]))),
                              child: TextFormField(
                                obscureText: passwordshow,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        passwordshow
                                            ? Icons.lock
                                            : Icons.remove_red_eye,
                                        color: Colors.grey.withOpacity(.8),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          passwordshow = !passwordshow;
                                        });
                                      },
                                    ),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(.8),
                                        fontFamily: 'R'),
                                    hintText: "Password"),
                                onChanged: (input) => password = input,
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.8,
                      Center(
                        child: Container(
                          width: 200.0,
                          child: MaterialButton(
                            color: Colors.white,
                            textColor: Colors.deepOrange,
                            elevation: 5.0,
                            height: 50.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {
                              register();
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 20.0, fontFamily: 'R'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            )),
      ),
      onWillPop: () {},
    );
  }

  Future<void> register() async {
    final formstate = fkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        await organizers(uid: user.user.uid).addUserData(name, email, number);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return organizer();
        }));
        widget.onSignedIn();
      } catch (e) {
        print(e);
      }
    }
  }

  void homepage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return organizer();
    }));
  }

  void lastPage() {
    Navigator.pop(context, true);
  }
}
