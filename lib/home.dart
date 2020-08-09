import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:meetup/eventDetails.dart';
import 'package:meetup/scrollbar.dart';

QuerySnapshot qn;
QuerySnapshot eqn;
List<DocumentSnapshot> orgList = [];
List<DocumentSnapshot> orgEventList = [];
List<DocumentSnapshot> tempEvent1 = [];
List<DocumentSnapshot> tempEvent2 = [];

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return homestate();
  }
}

class homestate extends State<home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<DocumentSnapshot> temp;

  Future getEvents() async {
    orgEventList = [];
    orgList = [];
    qn = await Firestore.instance.collection("organizer").getDocuments();
    orgList = qn.documents;
    print(orgList.length);
    for (int i = 0; i < orgList.length; i++) {
      print(orgList[i].documentID);
      eqn = await Firestore.instance
          .collection("organizer")
          .document(orgList[i].documentID)
          .collection("events")
          .getDocuments();
      orgEventList.addAll(eqn.documents);
    }
    tempEvent1 = orgEventList;
    tempEvent2 = orgEventList;
  }

  @override
  void initState() {
    super.initState();
    tempEvent1 = orgEventList;
    tempEvent2 = orgEventList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFFFFEFEA),
        appBar: AppBar(
          leading: Container(),
          title: Text(
            'Evently',
            style: TextStyle(fontFamily: 'R'),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                scrollbar();
              },
              iconSize: 37.0,
            ),
          ],
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Tab(text: 'ALL'),
              Tab(text: 'GOING'),
              Tab(text: 'PAST')
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FutureBuilder(
                future: getEvents(),
                builder: (_, eqn) {
                  if (eqn.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        width: 70,
                        height: 70,
                        child: LiquidCircularProgressIndicator(
                          value: 0.5,
                          valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
                          backgroundColor: Colors.white,
                          borderColor: Colors.deepOrange,
                          borderWidth: 5.0,
                          direction: Axis.vertical,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: orgEventList.length,
                        itemBuilder: (_, index) {
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
                                        edesc: orgEventList[index]
                                            .data["description"],
                                            etime:orgEventList[index].data["time"],
                                            mode:orgEventList[index].data["mode"],
                                        edate: orgEventList[index].data["date"],
                                        eposter: orgEventList[index].data['posterlink'],
                                        edest: orgEventList[index]
                                            .data["destination"])));
                              },
                              elevation: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 0.6, color: Color(0xFFFF5722)),
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
                                        height:
                                            MediaQuery.of(context).size.width,
                                        //width: 100,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 9.0, right: 0),
                                          width: 65,
                                          height: 65,
                                          decoration: new BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            //crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                    "${orgEventList[index].data["date"].toString().substring(0, 3)}",
                                                    style: TextStyle(
                                                      fontFamily: 'R',
                                                      color: Color(0xffff5722),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    )),
                                              ),
                                              Container(
                                                child: Text(
                                                    "${orgEventList[index].data["date"].toString().substring(4, 5)}",
                                                    style: TextStyle(
                                                      fontFamily: 'R',
                                                      color: Color(0xff303030),
                                                      fontSize: 21,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      orgEventList[index].data["mode"] ==
                                              'Online'
                                          ? Container(
                                              alignment: Alignment.topRight,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.only(
                                                  left: 61, top: 81),
                                              padding: EdgeInsets.all(0),
                                              child: Container(
                                                //margin: EdgeInsets.only(left: 9.0, right: 0),
                                                height: 22,
                                                width: 22,
                                                decoration: new BoxDecoration(
                                                  border: Border.all(
                                                      width: 1.0,
                                                      color: Colors.deepOrange),
                                                  color: Color(0xffffffff),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:
                                                            Color(0x29000000),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              decoration: BoxDecoration(
                                                  // border: Border.all(
                                                  //     width: 1.0, color: Colors.black),
                                                  ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  149,
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  149,
                                              decoration: BoxDecoration(
                                                  // border: Border.all(
                                                  //     width: 1.0, color: Colors.black),
                                                  ),
                                              //padding: EdgeInsets.only(top: 10.0),
                                              child: Text(
                                                  "${orgEventList[index].data["name"]}",
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
                        });
                  }
                }),
            Container(
              height: 100,
              width: 100,
              child: ListView.builder(
                  itemCount: tempEvent1.length,
                  itemBuilder: (_, index) {
                    if (tempEvent1[index].data['date'].toString() ==
                        DateFormat.yMMMd().format(DateTime.now()).toString()) {
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
                                  eposter: orgEventList[index].data['posterlink'],
                                    efees: orgEventList[index].data["fees"],
                                    mode:orgEventList[index].data['mode'],
                                    ename: orgEventList[index].data["name"],
                                    edesc:
                                        orgEventList[index].data["description"],
                                    edate: orgEventList[index].data["date"],
                                    edest: orgEventList[index]
                                        .data["destination"])));
                          },
                          elevation: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 0.6, color: Color(0xFFFF5722)),
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
                                      margin:
                                          EdgeInsets.only(left: 9.0, right: 0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                          height:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(
                                              left: 61, top: 81),
                                          padding: EdgeInsets.all(0),
                                          child: Container(
                                            //margin: EdgeInsets.only(left: 9.0, right: 0),
                                            height: 22,
                                            width: 22,
                                            decoration: new BoxDecoration(
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.deepOrange),
                                              color: Color(0xffffffff),
                                              borderRadius:
                                                  BorderRadius.circular(100),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              149,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              149,
                                          decoration: BoxDecoration(
                                              // border: Border.all(
                                              //     width: 1.0, color: Colors.black),
                                              ),
                                          //padding: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                              "${orgEventList[index].data["name"]}",
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
                  }),
            ),
            Container(
              height: 100,
              width: 100,
              child: ListView.builder(
                  itemCount: tempEvent2.length,
                  itemBuilder: (_, index) {
                    if (DateFormat.yMMMd()
                        .parse(tempEvent2[index].data['date'])
                        .isBefore(DateTime.now().subtract(Duration(days: 1)))) {
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
                                    mode:orgEventList[index].data['mode'],
                                    eposter: orgEventList[index].data['posterlink'],
                                    ename: orgEventList[index].data["name"],
                                    edesc:
                                        orgEventList[index].data["description"],
                                    edate: orgEventList[index].data["date"],
                                    edest: orgEventList[index]
                                        .data["destination"])));
                          },
                          elevation: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 0.6, color: Color(0xFFFF5722)),
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
                                      margin:
                                          EdgeInsets.only(left: 9.0, right: 0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                          height:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(
                                              left: 61, top: 81),
                                          padding: EdgeInsets.all(0),
                                          child: Container(
                                            //margin: EdgeInsets.only(left: 9.0, right: 0),
                                            height: 22,
                                            width: 22,
                                            decoration: new BoxDecoration(
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.deepOrange),
                                              color: Color(0xffffffff),
                                              borderRadius:
                                                  BorderRadius.circular(100),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              149,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              149,
                                          decoration: BoxDecoration(
                                              // border: Border.all(
                                              //     width: 1.0, color: Colors.black),
                                              ),
                                          //padding: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                              "${orgEventList[index].data["name"]}",
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
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildlist(List<DocumentSnapshot> list, String key) {
    return ListView.builder(
        key: PageStorageKey(key),
        itemCount: list.length,
        itemBuilder: (_, index) {
          return Container(
            margin: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width - 50.0,
            height: 120.0,
            child: MaterialButton(
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              textColor: Colors.white,
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {},
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20.0, right: 15.0),
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 1.0, color: Colors.white)),
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
                                "Name : ${list[index].data["name"]}",
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
                                style:
                                    TextStyle(fontSize: 15.0, fontFamily: 'R'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                "Description :\n ${list[index].data["description"]}",
                                style:
                                    TextStyle(fontSize: 15.0, fontFamily: 'R'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                "Fees : ${list[index].data["fees"]}",
                                style:
                                    TextStyle(fontSize: 15.0, fontFamily: 'R'),
                              ),
                            )
                          ]),
                    ),
                  ]),
            ),
          );
        });
  }

  void scrollbar() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return account_bar();
    }));
  }

  void lastPage() {
    Navigator.pop(context, true);
  }
}
