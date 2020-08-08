import 'package:flutter/material.dart';
import 'package:meetup/scrollbar.dart';
import 'package:meetup/FirstPage.dart';
import 'package:meetup/home.dart';
import 'package:meetup/search.dart';
import 'package:meetup/notification.dart';
import 'package:meetup/signup.dart';

void main() => runApp(MaterialApp(
      title: 'Evently',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: FirstPage()
    ));

class mainhome extends StatefulWidget {
  final VoidCallback onSignedOut;

  const mainhome({this.onSignedOut});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homestate();
  }
}

class homestate extends State<mainhome> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  int _currentIndex = 0;
  final List<Widget> _children = [
    home(),
    Search(),
    first_signup(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        // backgroundColor: Colors.white,
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFFFFEFEA),
          currentIndex: _currentIndex,
          iconSize: 23,
          selectedFontSize: 12,
          onTap: onTappedBar,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              title: new Text('Search'),
              backgroundColor: Colors.white,
            ),
            // BottomNavigationBarItem(
            //   icon: new Icon(Icons.notifications_active),
            //   title: new Text('Notifications'),
            //   backgroundColor: Colors.white,
            // ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.message),
              title: new Text('Messages'),
              backgroundColor: Colors.white,
            ),
          ],
          // currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          elevation: 0.0,
        ),
    ) ;
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
