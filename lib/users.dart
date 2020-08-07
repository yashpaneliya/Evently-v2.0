import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
class users {

  String name;
  String surname;
  String email;
  String number;
  String eventname;
  String eventorganizer;
  String eventdate;
  String fees;

  final String uid;

  users({this.uid});

  final CollectionReference ref = Firestore.instance.collection('users');
  final CollectionReference ref2 = Firestore.instance.collection('users');

  Future addUserData(String name, String surname, String email,
      String number) async {
    return await ref.document(uid).setData({
      'Name': name,
      'Surname': surname,
      'Email': email,
      'Number': number,
    });
  }

  Future addEventData(String eventname, String eventorganizer,String eventdate,String fees)async{
    return await ref2.document(uid).collection('events').document(randomString(10)).setData({
      'name':eventname,
      'org':eventorganizer,
      'date':eventdate,
      'fees':fees
    });
  }

  @override
  Future<String> currentUser() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }
}