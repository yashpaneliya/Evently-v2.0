import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:meetup/orgEventDetails.dart';

QuerySnapshot qn;

class orgEvent extends StatefulWidget {
  @override
  _orgEventState createState() => _orgEventState();
}

class _orgEventState extends State<orgEvent> {
  Future getpoasts() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    qn = await Firestore.instance
        .collection("organizer")
        .document(uid)
        .collection('events')
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getpoasts(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              width: 70,
              height: 70,
              child: LiquidCircularProgressIndicator(
                value: 0.5,
                // Defaults to 0.5.
                valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
                // Defaults to the current Theme's accentColor.
                backgroundColor: Colors.white,
                // Defaults to the current Theme's backgroundColor.
                borderColor: Colors.deepOrange,
                borderWidth: 5.0,
                direction: Axis.vertical,
                // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
              ),
            ),
          );
        } else if (snapshot.data.length == 0) {
          return Center(
              child: Text(
            'No data found!!!',
            style: TextStyle(fontFamily: 'R'),
          ));
        } else {
          return Scaffold(
            backgroundColor: Color(0xFFFFEFEA),
            body: SafeArea(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
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
                              builder: (context) => orgEventDetail(
                                mode: snapshot.data[index].data['mode'],
                                etime: snapshot.data[index].data['time'],
                                eposter: snapshot.data[index].data['posterlink'],
                                  efees: snapshot.data[index].data["fees"],
                                  ename: snapshot.data[index].data["name"],
                                  edesc: snapshot.data[index].data["description"],
                                  edate: snapshot.data[index].data["date"],
                                  edest: snapshot.data[index].data["destination"])));
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
                                              "${snapshot.data[index].data["date"].toString().substring(0, 3)}",
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
                                              "${snapshot.data[index].data["date"].toString().substring(4, 5)}",
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
                                snapshot.data[index].data["mode"] == 'Online'
                                    ? Container(
                                        alignment: Alignment.topRight,
                                        height:
                                            MediaQuery.of(context).size.width,
                                        margin:
                                            EdgeInsets.only(left: 61, top: 81),
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
                                        width:
                                            MediaQuery.of(context).size.width -
                                                149,
                                        //padding: EdgeInsets.only(top: 10.0),
                                        child: Text(
                                            "${snapshot.data[index].data["organizer"]}",
                                            style: TextStyle(
                                              fontFamily: 'R',
                                              color: Color(0xff000000),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300,
                                              fontStyle: FontStyle.normal,
                                            ))),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                149,
                                        decoration: BoxDecoration(
                                            // border: Border.all(
                                            //     width: 1.0, color: Colors.black),
                                            ),
                                        //padding: EdgeInsets.only(top: 10.0),
                                        child: Text(
                                            "${snapshot.data[index].data["name"]}",
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

                    // return Container(
                    //   margin: EdgeInsets.all(10.0),
                    //   width: 800,
                    //   height: 100,
                    //   child: MaterialButton(
                    //     color: Colors
                    //         .primaries[Random().nextInt(Colors.primaries.length)],
                    //     textColor: Colors.white,
                    //     elevation: 10.0,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(20.0),
                    //     ),
                    //     onPressed: () {
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //           builder: (context) => orgEventDetail(
                    //               efees: snapshot.data[index].data["fees"],
                    //               ename: snapshot.data[index].data["name"],
                    //               edesc: snapshot.data[index].data["description"],
                    //               edate: snapshot.data[index].data["date"],
                    //               edest:
                    //                   snapshot.data[index].data["destination"])));
                    //     },
                    //     child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: <Widget>[
                    //           Container(
                    //             padding: EdgeInsets.only(top: 20.0, right: 15.0),
                    //             width: 90.0,
                    //             height: 70.0,
                    //             decoration: BoxDecoration(
                    //               border: Border(
                    //                   right: BorderSide(
                    //                       width: 1.0, color: Colors.white)),
                    //             ),
                    //             child: Text(
                    //               "LOGO",
                    //               style: TextStyle(fontSize: 20.0, fontFamily: 'R'),
                    //             ),
                    //           ),
                    //           Expanded(
                    //             child: Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 children: <Widget>[
                    //                   Container(
                    //                     padding: EdgeInsets.only(top: 10.0),
                    //                     child: Text(
                    //                       "${snapshot.data[index].data["name"]}",
                    //                       style: TextStyle(
                    //                           fontSize: 15.0,
                    //                           fontFamily: 'R',
                    //                           fontWeight: FontWeight.bold),
                    //                     ),
                    //                   ),
                    //                   Container(
                    //                     padding: EdgeInsets.only(top: 10.0),
                    //                     child: Text(
                    //                       "${snapshot.data[index].data["date"]}",
                    //                       style: TextStyle(
                    //                           fontSize: 15.0, fontFamily: 'R'),
                    //                     ),
                    //                   ),
                    //                   Container(
                    //                     padding: EdgeInsets.only(top: 10.0),
                    //                     child: Text(
                    //                       "${snapshot.data[index].data["fees"]}",
                    //                       style: TextStyle(
                    //                           fontSize: 10.0, fontFamily: 'R'),
                    //                     ),
                    //                   )
                    //                 ]),
                    //           ),
                    //         ]),
                    //   ),
                    // );
                  }),
            ),
          );
        }
      },
    );
  }
}
