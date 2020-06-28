import 'package:bharatsevakadmin/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth mAuth;
  int flag = 1;
  void logout() {
    setState(() {
      flag = 0;
    });
    mAuth = FirebaseAuth.instance;
    mAuth.signOut().then((v) {
      Navigator.pushReplacementNamed(context, Login.routeName);
    });
    setState(() {
      flag = 1;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: logout,
            icon: Icon(Icons.arrow_back),
            label: Text("logout"),
          ),
        ],
      ),
      body: flag == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child:Text("No recent orders"),
            ),
    );
  }
}
