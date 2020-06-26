import './screens/services.dart';
import 'package:flutter/material.dart';
import './screens/addservice.dart';
import './screens/nav_screen.dart';
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
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavScreen(),
      routes: {
       Services.routeName:(ctx)=>Services(),
       AddService.routeName:(ctx)=>AddService(),
      },
    );
  }
}