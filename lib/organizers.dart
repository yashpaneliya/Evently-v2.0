import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';

class organizers {

  String name;
  String email;
  String number;
  String eventname;
  String eventdesc;
  String eventdate;
  String fees;
  String posterlink;

  final String uid;

  organizers({this.uid});

  final CollectionReference ref = Firestore.instance.collection('organizer');
  final CollectionReference ref2 = Firestore.instance.collection('organizer');

  Future addUserData(String name, String email,
      String number) async {
    return await ref.document(uid).setData({
      'name': name,
      'email': email,
      'number': number,
    });
  }

  Future addEventData(String eventname, String desc,String eventdate,String eventtime,String fees,String org,String mode,String dest,String url)async{
    return await ref2.document(uid).collection('events').document(randomString(10)).setData({
      'name':eventname,
      'description':desc,
      'date':eventdate,
      'time':eventtime,
      'fees':fees,
      'organizer': org,
      'mode':mode,
      'destination':dest,
      'posterlink': url, 
    });
  }

  @override
  Future<String> currentUser() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }
}
