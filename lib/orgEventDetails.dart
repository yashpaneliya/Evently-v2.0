import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class orgEventDetail extends StatefulWidget {
  final String ename, edesc, edate, efees, etime, mode, edest, eposter;

  const orgEventDetail(
      {this.ename,
      this.edesc,
      this.edate,
      this.efees,
      this.etime,
      this.mode,
      this.edest,
      this.eposter});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailState(ename, edesc, edate, efees, edest);
  }
}

class detailState extends State<orgEventDetail> {
  final String ename, edesc, edate, efees, edest;

  detailState(this.ename, this.edesc, this.edate, this.efees, this.edest);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEFEA),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(color: Color(0xffffefea)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      //border: Border.all(width: 1.0, color: Colors.black),
                      ),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(03, 0, 0, 0),
                          child: IconButton(
                              //padding: EdgeInsets.only(top: 4),
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.deepOrange,
                                size: 28,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                // print("object1234");
                              })),
                      Container(
                        padding: EdgeInsets.fromLTRB(11, 2, 0, 0),
                        child: Text("Event Details",
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Color(0xffff5722),
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(27, 0, 27, 0),
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.eposter),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      width: MediaQuery.of(context).size.width,
                      height: 236,
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Color(0xFFFFEFEA),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      width: MediaQuery.of(context).size.width,
                      height: 231,
                      padding: EdgeInsets.only(right: 15),
                      child: Container(
                          padding: EdgeInsets.only(bottom: 5),
                          alignment: Alignment.center,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x29000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 8,
                                  spreadRadius: 02)
                            ],
                          ),
                          child: IconButton(
                              padding: EdgeInsets.only(top: 4),
                              icon: Icon(
                                Icons.zoom_in,
                                color: Colors.deepOrange,
                                size: 33,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HeroPhotoViewWrapper(
                                      imageProvider: NetworkImage(
                                        widget.eposter,
                                      ),
                                    ),
                                  ),
                                );
                                //print("object1234");
                              })),
                    ),
                  ],
                ),

                Container(
                    margin: EdgeInsets.fromLTRB(27, 5, 27, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Text("${widget.ename}",
                        style: TextStyle(
                          fontFamily: 'R',
                          color: Color(0xff303030),
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ))),
                Container(
                    margin: EdgeInsets.fromLTRB(27, 16, 27, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Text("${widget.edesc}",
                        style: TextStyle(
                          fontFamily: 'R',
                          color: Color(0xff000000),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ))),
                Container(
                    margin: EdgeInsets.fromLTRB(47, 25, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: new BoxDecoration(),
                          child: Icon(
                            Icons.access_time,
                            color: Color(0xff303030),
                            size: 25.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Text("${widget.edate} - ${widget.etime}",
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xff000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      ],
                    )),
                Container(
                    decoration: new BoxDecoration(
                        // border: Border.all(width: 1.0, color: Colors.deepOrange),
                        ),
                    margin: EdgeInsets.fromLTRB(47, 12, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: new BoxDecoration(),
                          child: Icon(
                            Icons.videocam,
                            color: Color(0xff303030),
                            size: 25.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Text("${widget.mode}",
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Color(0xff000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      ],
                    )),
                Container(
                    decoration: new BoxDecoration(
                        // border: Border.all(width: 1.0, color: Colors.deepOrange),
                        ),
                    margin: EdgeInsets.fromLTRB(47, 12, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(06, 0, 0, 0),
                          decoration: new BoxDecoration(),
                          child: Text("₹",
                              style: TextStyle(
                                fontFamily: 'R',
                                color: Color(0xff303030),
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text("${widget.efees} (per head)",
                              style: TextStyle(
                                fontFamily: 'R',
                                color: Color(0xff000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(47, 12, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: new BoxDecoration(),
                          child: Icon(
                            Icons.location_on,
                            color: Color(0xff303030),
                            size: 25.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Text("${widget.edest}",
                              style: TextStyle(
                                fontFamily: 'R',
                                color: Color(0xff000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeroPhotoViewWrapper extends StatelessWidget {
  const HeroPhotoViewWrapper({
    this.imageProvider,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        loadingBuilder: loadingBuilder,
        backgroundDecoration: backgroundDecoration,
        minScale: minScale,
        maxScale: maxScale,
        heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
      ),
    );
  }
}