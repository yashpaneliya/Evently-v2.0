import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meetup/organier.dart';
import 'package:meetup/organizersignup.dart';
import 'Animations/FadeAnimation.dart';

class org_login extends StatefulWidget {
  final VoidCallback onSignedIn;
  const org_login({this.onSignedIn});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return org_login_state();
  }
}

class org_login_state extends State<org_login> {
  bool passwordShow = true;
  String email, password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    passwordShow = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var passwordshow = true;
    return Scaffold(
        backgroundColor: Colors.deepOrange,
        body: SingleChildScrollView(
                  child: Form(
            key: _formkey,
              child: Container(
              margin: EdgeInsets.only(top:100.0),
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeAnimation(
                  1.0,
                  Container(
                    child: Text(
                      "Organizer Login",
                      style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'R'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                FadeAnimation(
                    1.5,
                    Container(
                      padding: EdgeInsets.all(10.0),
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
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8),
                                      fontFamily: 'R'),
                                  hintText: "Institute Email"),
                              onChanged: (input)=>email=input,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
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
                              onChanged: (input)=>password=input,
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
                            signIn();
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20.0, fontFamily: 'R'),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 15.0,
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
                            signup();
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20.0, fontFamily: 'R'),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          )),
        ),
      );
  }

  Future<void> signIn() async {
    final formState = _formkey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        widget.onSignedIn();
      } catch (e) {
        print(e);
      }
      FirebaseUser user2 = await FirebaseAuth.instance.currentUser();
      print(user2);
      if (user2 != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => organizer()));
      } else {}
    }
  }

  void homepage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return organizer();
    }));
  }

  void signup() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return org_signup();
    }));
  }

  void lastPage() {
    Navigator.pop(context, true);
  }
}
