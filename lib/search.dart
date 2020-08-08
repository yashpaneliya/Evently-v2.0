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
                  margin: EdgeInsets.only(top: 260),
                  width: MediaQuery.of(context).size.width,
                  height: 400.0,
                  child: listOfEvent(search),
                ),
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
                        offset: Offset(0, 2.0),
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
    // setState(() {
    return ListView.builder(
        itemCount: orgEventList.length,
        itemBuilder: (_, index) {
          if (orgEventList[index]
              .data['name']
              .toString()
              .contains(searchHint)) {
            return Container(
              decoration: BoxDecoration(
                  //border: Border.all(width: 1.0, color: Colors.black),
                  ),
              //margin: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              height: 120.0,
              child: MaterialButton(
                color: Color(0xFFFFEFEA),
                // textColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => eventDetail(
                          efees: orgEventList[index].data["fees"],
                          ename: orgEventList[index].data["name"],
                          edesc: orgEventList[index].data["description"],
                          etime: orgEventList[index].data["time"],
                          mode: orgEventList[index].data["mode"],
                          edate: orgEventList[index].data["date"],
                          eposter: orgEventList[index].data['posterlink'],
                          edest: orgEventList[index].data["destination"])));
                },
                elevation: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.6, color: Color(0xFFFF5722)),
                    ),
                  ),
                  child: Row(children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              // border:
                              //     Border.all(width: 1.0, color: Colors.black),
                              ),
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width,
                          //width: 100,
                          child: Container(
                            margin: EdgeInsets.only(left: 9.0, right: 0),
                            width: 65,
                            height: 65,
                            decoration: new BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                    spreadRadius: 0)
                              ],
                            ),
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                      "${orgEventList[index].data["date"].toString().substring(0, 3)}",
                                      style: TextStyle(
                                        fontFamily: 'R',
                                        color: Color(0xffff5722),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                                Container(
                                  child: Text(
                                      "${orgEventList[index].data["date"].toString().substring(4, 5)}",
                                      style: TextStyle(
                                        fontFamily: 'R',
                                        color: Color(0xff303030),
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        orgEventList[index].data["mode"] == 'Online'
                            ? Container(
                                alignment: Alignment.topRight,
                                height: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 61, top: 81),
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  //margin: EdgeInsets.only(left: 9.0, right: 0),
                                  height: 22,
                                  width: 22,
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.deepOrange),
                                    color: Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x29000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                          spreadRadius: 0)
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.videocam,
                                    color: Colors.deepOrange,
                                    size: 17.0,
                                    semanticLabel:
                                        'Text to announce in accessibility modes',
                                  ),
                                ))
                            : Container(),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 33.0),
                      //width: ,
                      decoration: BoxDecoration(
                          // border:
                          //     Border.all(width: 1.0, color: Colors.white),
                          ),
                      child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    // border: Border.all(
                                    //     width: 1.0, color: Colors.black),
                                    ),
                                width: MediaQuery.of(context).size.width - 149,
                                //padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                    "${orgEventList[index].data["organizer"]}",
                                    style: TextStyle(
                                      fontFamily: 'R',
                                      color: Color(0xff000000),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.normal,
                                    ))),
                            Container(
                                width: MediaQuery.of(context).size.width - 149,
                                decoration: BoxDecoration(
                                    // border: Border.all(
                                    //     width: 1.0, color: Colors.black),
                                    ),
                                //padding: EdgeInsets.only(top: 10.0),
                                child:
                                    Text("${orgEventList[index].data["name"]}",
                                        style: TextStyle(
                                          fontFamily: 'R',
                                          color: Color(0xff303030),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        ))),
                          ]),
                    ),
                  ]),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
    // });
  }
}
