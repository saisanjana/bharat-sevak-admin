import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './addservice.dart';
class Services extends StatefulWidget {
  static const routeName = 'sevices';

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  int flag = 1;
  void toggle() {
    setState(() {
      flag == 1 ? flag = 0 : flag = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeargs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    var areaname = routeargs['areaname'];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddService.routeName,arguments: {'areaname':areaname});
        },
      ),
      appBar: AppBar(
        title: Text("Services and products"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                            MediaQuery.of(context).size.width * 0.1),
                      ),
                    ),
                    color: flag == 0 ? Colors.green : Colors.grey,
                    onPressed: toggle,
                    child: Text("Services"),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                            MediaQuery.of(context).size.width * 0.1),
                      ),
                    ),
                    color: flag == 1 ? Colors.green : Colors.grey,
                    onPressed: toggle,
                    child: Text("Products"),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: flag == 1
                    ? StreamBuilder(
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
                                child: Card(
                                  color: i % 2 != 0
                                      ? Colors.green
                                      : Colors.green[300],
                                  elevation: 3,
                                  child: Container(
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        _lst[i]['productname'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : StreamBuilder(
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
    );
  }
}
