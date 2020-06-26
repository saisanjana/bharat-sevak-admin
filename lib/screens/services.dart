import './servicedetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './addservice.dart';

class Services extends StatefulWidget {
  static const routeName = 'sevices';

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    final routeargs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    var areaname = routeargs['areaname'];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddService.routeName,
                arguments: {'areaname': areaname,'type':"service"});
          },
        ),
        appBar: AppBar(
          title: Text(areaname),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: "Products"),
              Tab(text: "Services"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('areas')
                            .document(areaname)
                            .collection('products')
                            .snapshots(),
                        builder: (ctx, snaps) {
                          if (snaps.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          List<dynamic> _lst = snaps.data.documents as dynamic;
                          if (_lst.length == 0) {
                            return Center(
                              child: Text("No products added"),
                            );
                          }
                          return ListView.builder(
                            itemCount: _lst.length,
                            itemBuilder: (ctx, i) {
                              return Container(
                                padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  right:
                                      MediaQuery.of(context).size.width * 0.05,
                                  top: MediaQuery.of(context).size.width * 0.05,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(Details.routeName,arguments: {'details':_lst[i],'type':"product"});
                                  },
                                  child: Card(
                                    color: i % 2 != 0
                                        ? Colors.green
                                        : Colors.green[300],
                                    elevation: 3,
                                    child: Container(
                                      height: 100,
                                      child: Center(
                                        child: Text(
                                          _lst[i]['productName'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('areas')
                            .document(areaname)
                            .collection('services')
                            .snapshots(),
                        builder: (ctx, snaps) {
                          if (snaps.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          List<dynamic> _lst = snaps.data.documents as dynamic;
                          if (_lst.length == 0) {
                            return Center(
                              child: Text("No Services added"),
                            );
                          }
                          return ListView.builder(
                            itemCount: _lst.length,
                            itemBuilder: (ctx, i) {
                              return Container(
                                padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  right:
                                      MediaQuery.of(context).size.width * 0.05,
                                  top: MediaQuery.of(context).size.width * 0.05,
                                ),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pushNamed(Details.routeName,arguments: {'details':_lst[i]});
                                  },
                                  child: Card(
                                    color: i % 2 != 0
                                        ? Colors.green
                                        : Colors.green[300],
                                    elevation: 3,
                                    child: Container(
                                      height: 100,
                                      child: Center(
                                        child: Text(
                                          _lst[i]['serviceName'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Container(),
          ],
        ),
      ),
    );
  }
}
