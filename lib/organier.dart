import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:meetup/orgEventsList.dart';
import 'package:meetup/orgNotification.dart';
import 'package:meetup/orgProfile.dart';
import 'package:meetup/orgSettings.dart';
import 'package:meetup/scrollbar.dart';

import 'authentication/auth.dart';
import 'authentication/auth_provider.dart';
import 'newEvent.dart';

QuerySnapshot qn;

class organizer extends StatefulWidget {
  final VoidCallback onSignedOut;

  const organizer({this.onSignedOut});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return organierstate();
  }
}

class organierstate extends State<organizer> {
  bool select = true;
  int currentTab = 0;
  final List<Widget> screens = [
    orgEvent(),
    // orgSetting(),
    orgProfile(),
    // orgNoti(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = orgEvent();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Past',
      style: optionStyle,
    ),
    Text(
      'Index 1: Setting',
      style: optionStyle,
    ),
    Text(
      'Index 2: Account',
      style: optionStyle,
    ),
    Text(
      'Index 3: Messages',
      style: optionStyle,
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          // appBar: AppBar(
          //   leading: Container(),
          //   // centerTitle: true,
          // ),
          body: DoubleBackToCloseApp(
            snackBar: const SnackBar(content: Text('Tap Back to exit')),
            child: SafeArea(
              child: PageStorage(
                child: currentScreen,
                bucket: bucket,
              ),
            ),
          ),
          //Column(
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.only(left: 40.0,top: 100.0),
//                width: MediaQuery.of(context).size.width-100.0,
//                height: MediaQuery.of(context).size.height-710.0,
//                child: MaterialButton(
//                  elevation: 4.0,
//                  child: Text('Log Out'),
//                  color: Colors.deepOrange,
//                  onPressed: (){
//                    _signOut(context);
//                    Route route = MaterialPageRoute(
//                        builder: (context) => FirstPage());
//                    Navigator.pushReplacement(context, route);
//                  },
//                ),
//              )
//            ],
//          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return addEvent();
              }));
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 10,
              child: Container(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 30.0,
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen =
                                  orgEvent(); // if user taps on this homepage tab will be active
                              currentTab = 0;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: currentTab == 0
                                    ? Colors.deepOrange
                                    : Colors.grey,
                              ),
                              Visibility(
                                  visible: currentTab == 0 ? true : false,
                                  child: Text(
                                    'Past',
                                    style: TextStyle(
                                      color: currentTab == 0
                                          ? Colors.deepOrange
                                          : Colors.grey,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        // MaterialButton(
                        //   minWidth: 40,
                        //   onPressed: () {
                        //     setState(() {
                        //       currentScreen =
                        //           orgSetting(); // if user taps on this dashboard tab will be active
                        //       currentTab = 1;
                        //     });
                        //   },
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: <Widget>[
                        //       Icon(
                        //         Icons.settings,
                        //         color: currentTab == 1
                        //             ? Colors.deepOrange
                        //             : Colors.grey,
                        //       ),
                        //       Visibility(
                        //         visible: currentTab == 1 ? true : false,
                        //         child: Text(
                        //           'Settings',
                        //           style: TextStyle(
                        //             color: currentTab == 1
                        //                 ? Colors.deepOrange
                        //                 : Colors.grey,
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // )
                      ],
                    ),

                    // Right Tab bar icons

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen =
                                  orgProfile(); // if user taps on this dashboard tab will be active
                              currentTab = 2;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.account_circle,
                                color: currentTab == 2
                                    ? Colors.deepOrange
                                    : Colors.grey,
                              ),
                              Visibility(
                                visible: currentTab == 2 ? true : false,
                                child: Text(
                                  'Profile',
                                  style: TextStyle(
                                    color: currentTab == 2
                                        ? Colors.deepOrange
                                        : Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // MaterialButton(
                        //   minWidth: 40,
                        //   onPressed: () {
                        //     setState(() {
                        //       currentScreen =
                        //           orgNoti(); // if user taps on this dashboard tab will be active
                        //       currentTab = 3;
                        //     });
                        //   },
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: <Widget>[
                        //       Icon(
                        //         Icons.notifications,
                        //         color: currentTab == 3
                        //             ? Colors.deepOrange
                        //             : Colors.grey,
                        //       ),
                        //       Visibility(
                        //         visible: currentTab == 3 ? true : false,
                        //         child: Text(
                        //           'Notifications',
                        //           style: TextStyle(
                        //             color: currentTab == 3
                        //                 ? Colors.deepOrange
                        //                 : Colors.grey,
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          width: 30.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }

  void scrollbar() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return account_bar();
    }));
  }

  void event() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return eventpage();
    }));
  }

  void lastPage() {
    Navigator.pop(context, true);
  }
}