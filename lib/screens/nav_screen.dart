import 'package:flutter/material.dart';
import './areas.dart';
import './home.dart';
import './orders.dart';
import './users.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  List<Widget> _screens = [
    Home(),
    Area(),
    User(),
    Order(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: _screens,
        ),
        bottomNavigationBar: TabBar(
          
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home,color: Colors.green[700],),
            ),
            Tab(
              icon: Icon(Icons.location_city, color: Colors.green[700], ),
            ),
            Tab(
              icon: Icon(Icons.person, color: Colors.green[700], ),
            ),
            Tab(
              icon: Icon(Icons.shopping_basket , color: Colors.green[700], ),
            ),
          ],
          //unselectedLabelColor: Color.fromRGBO(127, 255, 0, 0),
        ),
      ),
    );
  }
}
