import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meetup/main.dart';
import 'package:meetup/users.dart';
import 'Animations/FadeAnimation.dart';

class first_signup extends StatefulWidget {
  final VoidCallback onSignedIn;
  const first_signup({this.onSignedIn});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return signup();
  }
}

class signup extends State<first_signup> {
  final GlobalKey<FormState> fkey = GlobalKey<FormState>();
  String email, password, name, surname, number;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var passwordshow = true;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.deepOrange,
        body: SingleChildScrollView(
          child: Form(
              key: fkey,
              child: Container(
                margin: EdgeInsets.only(top: 100),
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(
                      1.0,
                      Container(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          "Sign Up",
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
                        Form(
                            child: Container(
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
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(.8),
                                              fontFamily: 'R'),
                                          hintText: "First Name"),
                                      onChanged: (input) => name = input,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter last name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(.8),
                                              fontFamily: 'R'),
                                          hintText: "Last Name"),
                                      onChanged: (input) => surname = input,
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
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter email';
                                    }
                                    return null;
                                  },
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
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter number';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(.8),
                                          fontFamily: 'R'),
                                      hintText: "Phone number"),
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
                                  onChanged: (input) => password = input,
                                ),
                              ),
                            ],
                          ),
                        ))),
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
                                style:
                                    TextStyle(fontSize: 20.0, fontFamily: 'R'),
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
      ),
      onWillPop: () {},
    );
  }

  void homepage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return mainhome();
    }));
  }

  void lastPage() {
    Navigator.pop(context, true);
  }

  Future<void> register() async {
    final formstate = fkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        await users(uid: user.user.uid)
            .addUserData(name, surname, email, number);
        // await users(uid: user.user.uid)
            // .addEventData("event2", "self", "25/12/2020", "100");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return mainhome();
        }));
        widget.onSignedIn();
      } catch (e) {
        print(e);
      }
    }
  }
}
