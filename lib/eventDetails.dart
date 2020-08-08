import 'package:flutter/material.dart';

class eventDetail extends StatefulWidget {
  final String ename, edesc, edate, efees, orgname, edest;

  const eventDetail(
      {this.ename,
      this.edesc,
      this.edate,
      this.efees,
      this.orgname,
      this.edest});

  @override
  State<StatefulWidget> createState() {
    return detailState(ename, edesc, edate, efees, orgname, edest);
  }
}

class detailState extends State<eventDetail> {
  final String ename, edesc, edate, efees, orgname, edest;

  detailState(
      this.ename, this.edesc, this.edate, this.efees, this.orgname, this.edest);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          expandedHeight: 500.0,
          pinned: true,
          title: Text('Event Details'),
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/back2.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text(
                    'Event Name:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Text('$ename',
                      style: TextStyle(
                          fontSize: 20.0, color: Colors.black.withOpacity(.6))),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 20.0),
              child: Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 20.0),
              width: MediaQuery.of(context).size.width - 100.0,
              child: Text('$edesc',
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.black.withOpacity(.6))),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text(
                    'Date:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Text('$edate',
                      style: TextStyle(
                          fontSize: 20.0, color: Colors.black.withOpacity(.6))),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text(
                    'Fees:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Text('$efees (Per Head)',
                      style: TextStyle(
                          fontSize: 20.0, color: Colors.black.withOpacity(.6))),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text(
                    'Organizers:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Text('$orgname',
                      style: TextStyle(
                          fontSize: 20.0, color: Colors.black.withOpacity(.6))),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text(
                    'Destination :',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Text('$edest',
                      style: TextStyle(
                          fontSize: 20.0, color: Colors.black.withOpacity(.6))),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 30.0, left: 20.0, right: 20.0, bottom: 20.0),
              child: MaterialButton(
                height: 50.0,
                elevation: 10.0,
                color: Colors.deepOrange,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () {},
              ),
            )
          ]),
        )
      ],
    ));
  }
}
