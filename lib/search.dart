import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meetup/home.dart';

import 'eventDetails.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String search = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 225,
                  width: MediaQuery.of(context).size.width,
                  //padding: EdgeInsets.all(80),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    color: Colors.deepOrange,
                  ),
                  child: Center(
                    child: Text(
                      "Evently",
                      style: TextStyle(
                          fontSize: 60.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'R'),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 20, top: 5),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 200),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20.0,
                        offset: Offset(0, 20.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.black87,
                        size: 25,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search',
                    ),
                    onChanged: (input) {
                      print(input);
                      setState(() {
                        search = input;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 260, left: 20.0),
                  width: MediaQuery.of(context).size.width - 50.0,
                  height: 400.0,
                  child: listOfEvent(search),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listOfEvent(String searchHint) {
    print(searchHint);
    print(orgEventList.length);
    setState(() {
      return ListView.builder(
          itemCount: orgEventList.length,
          itemBuilder: (_, index) {
            if (orgEventList[index]
                .data['name']
                .toString()
                .contains(searchHint, 0)) {
              return Container(
                margin: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width - 50.0,
                height: 120.0,
                child: MaterialButton(
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  textColor: Colors.white,
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => eventDetail(
                              efees: orgEventList[index].data["fees"],
                              ename: orgEventList[index].data["name"],
                              edesc: orgEventList[index].data["description"],
                              edate: orgEventList[index].data["date"],
                              orgname: orgEventList[index].data['organizer'],
                              edest: orgEventList[index].data['destination'],
                            )));
                  },
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 20.0, right: 15.0),
                          width: 90.0,
                          height: 90.0,
                          decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1.0, color: Colors.white)),
                          ),
                          child: Text(
                            "LOGO",
                            style: TextStyle(fontSize: 20.0, fontFamily: 'R'),
                          ),
                        ),
                        Expanded(
                          child: Flex(
                              direction: Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Name : ${orgEventList[index].data["name"]}",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'R',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Date : ${orgEventList[index].data["date"]}",
                                    style: TextStyle(
                                        fontSize: 15.0, fontFamily: 'R'),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Fees : ${orgEventList[index].data["fees"]}",
                                    style: TextStyle(
                                        fontSize: 15.0, fontFamily: 'R'),
                                  ),
                                )
                              ]),
                        ),
                      ]),
                ),
              );
            } else {
              return Container();
            }
          });
    });
  }
}
