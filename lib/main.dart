import './screens/services.dart';
import 'package:flutter/material.dart';
import './screens/addservice.dart';
import './screens/servicedetails.dart';
import './screens/nav_screen.dart';
import './screens/editService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primaryColor: Color.fromRGBO(127, 255, 0, 0.7),
        //primarySwatch: Color. fromRGBO(r, g, b, opacity),
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: NavScreen(),
      home:Login(),
      routes: {
       Services.routeName:(ctx)=>Services(),
       AddService.routeName:(ctx)=>AddService(),
       Details.routeName:(ctx)=>Details(),
       EditService.routeName:(ctx)=>EditService(),
       NavScreen.routeName:(ctx)=>NavScreen(),
       Login.routeName:(ctx)=>Login(),
      },
    );
  }
}
