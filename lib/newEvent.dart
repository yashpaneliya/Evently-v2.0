import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'organier.dart';
import 'organizers.dart';

class addEvent extends StatefulWidget {
  @override
  _addEventState createState() => _addEventState();
}

class _addEventState extends State<addEvent> {
  String ename, edesc, edate, fees, orgname, edestination, elink;
  String radiovalue = "Offline";
  File imagefile;
  final ImagePicker picker = ImagePicker();
  DateTime selectedDate = DateTime.now();
  String etime = TimeOfDay.now().hour.toString() +
      " : " +
      TimeOfDay.now().minute.toString();

  final skey = GlobalKey<ScaffoldState>();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(Duration(days: 1, hours: 24)),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        edate = DateFormat.yMMMd().format(selectedDate.toLocal()).toString();
      });
    }
    print(edate);
    print(DateFormat.yMMMd().format(DateTime.now()).toString());
  }

  Future selectTime(BuildContext context) async {
    final tempTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    print(tempTime.format(context));
    if (tempTime != null) {
      setState(() {
        etime = tempTime.format(context).toString();
      });
    }
  }

  Future getImageformStorage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.imagefile = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: skey,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Add New Event',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text('Event Name'),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10.0,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 2.0)),
              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Enter event name'),
                onChanged: (input) => ename = input,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text('Description'),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10.0,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 2.0)),
              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Enter event details'),
                onChanged: (input) => edesc = input,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text('Date'),
            ),
            Container(
              height: 50.0,
              padding: EdgeInsets.all(
                10.0,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 2.0)),
              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Text(
                  '${DateFormat.yMMMd().format(selectedDate.toLocal())}',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text('Time'),
            ),
            Container(
              height: 50.0,
              padding: EdgeInsets.all(
                10.0,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 2.0)),
              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: InkWell(
                onTap: () {
                  selectTime(context);
                },
                child: Text(
                  '${etime}',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text('Fees'),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10.0,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 2.0)),
              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Enter fees'),
                onChanged: (input) => fees = input,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Offline',
                      groupValue: radiovalue,
                      onChanged: (value) {
                        setState(() {
                          radiovalue = value;
                          print(radiovalue);
                        });
                      },
                    ),
                    Text('Offline'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 'Online',
                      groupValue: radiovalue,
                      onChanged: (value) {
                        setState(() {
                          radiovalue = value;
                          print(radiovalue);
                        });
                      },
                    ),
                    Text('Online'),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: radiovalue == 'Offline',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text('Destination'),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 10.0,
                    ),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.deepOrange, width: 2.0)),
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter destination'),
                      onChanged: (input) => edestination = input,
                    ),
                  ),
                ],
              ),
            ),
            imagefile == null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: 20.0),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Image.file(imagefile),
                  ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: ListTile(
                onTap: () {
                  getImageformStorage();
                },
                title: Text('Pick Image'),
                trailing: Icon(Icons.file_upload),
              ),
            ),
            Center(
              child: Container(
                height: 45.0,
                width: MediaQuery.of(context).size.width - 100.0,
                margin: EdgeInsets.only(top: 40.0, bottom: 20.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  color: Colors.deepOrange,
                  elevation: 5.0,
                  child: Text(
                    'Add Event',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (imagefile == null) {
                      skey.currentState.showSnackBar(SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            'Select poster image please!!',
                            style: TextStyle(color: Colors.deepOrange),
                          )));
                      return;
                    }
                    addEventData();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future addEventData() async {
    if (radiovalue == 'Online') {
      edestination = 'Virtual';
    }
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference sref = storage.ref().child("$ename");
    StorageUploadTask task = sref.putFile(imagefile);
    StorageTaskSnapshot tasksnap = await task.onComplete;
    String url = await sref.getDownloadURL();
    print(url);
    DocumentSnapshot snap =
        await Firestore.instance.collection('organizer').document(uid).get();
    orgname = snap.data['name'];
    await organizers(uid: uid)
        .addEventData(ename, edesc, edate, etime, fees, orgname, radiovalue,
            edestination, url)
        .then((value) => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return organizer();
              }))
            });
  }
}
