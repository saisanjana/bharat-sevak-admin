
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './addservice.dart';
import './editService.dart';

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
                arguments: {'areaname': areaname, 'type': "service"});
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
                                    //print(_lst[i].documentID);
                                    Navigator.of(context).pushNamed(
                                        EditService.routeName,
                                        arguments: {
                                          'details': _lst[i],
                                          'type': "product",
                                          'area': areaname
                                        });
                                  },
                                  child: Card(
                                    color: i % 2 != 0
                                        ? Colors.green
                                        : Colors.green[300],
                                    elevation: 3,
                                    child: Container(
                                      child: ListTile(
                                        title: Text(
                                          _lst[i]['productName'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  title: Text("Confirm"),
                                                  content: Text(
                                                      "Are you sure you want to delete this product?"),
                                                  actions: <Widget>[
                                                    RaisedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("No"),
                                                    ),
                                                    RaisedButton.icon(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                        Firestore.instance
                                                            .collection('areas')
                                                            .document(areaname)
                                                            .collection(
                                                                'products')
                                                            .document(_lst[i]
                                                                .documentID)
                                                            .delete()
                                                            .then((value) {
                                                          showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        "Successfully deleted!"),
                                                                    content: Text(
                                                                        "The product is deleted"),
                                                                    actions: <
                                                                        Widget>[
                                                                      RaisedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: Text(
                                                                            "OKAY"),
                                                                      ),
                                                                    ],
                                                                  ));
                                                        });
                                                      },
                                                      icon: Icon(Icons.delete),
                                                      label: Text("Yes"),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
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
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        EditService.routeName,
                                        arguments: {
                                          'details': _lst[i],
                                          'type': "service",
                                          'area': areaname
                                        });
                                  },
                                  child: Card(
                                    color: i % 2 != 0
                                        ? Colors.green
                                        : Colors.green[300],
                                    elevation: 3,
                                    child: Container(
                                      child: ListTile(
                                        title: Text(
                                          _lst[i]['serviceName'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  title: Text("Confirm"),
                                                  content: Text(
                                                      "Are you sure you want to delete this Service?"),
                                                  actions: <Widget>[
                                                    RaisedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("No"),
                                                    ),
                                                    RaisedButton.icon(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                        Firestore.instance
                                                            .collection('areas')
                                                            .document(areaname)
                                                            .collection(
                                                                'services')
                                                            .document(_lst[i]
                                                                .documentID)
                                                            .delete()
                                                            .then((value) {
                                                          showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        "Successfully deleted!"),
                                                                    content: Text(
                                                                        "The Service is deleted"),
                                                                    actions: <
                                                                        Widget>[
                                                                      RaisedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: Text(
                                                                            "OKAY"),
                                                                      ),
                                                                    ],
                                                                  ));
                                                        });
                                                      },
                                                      icon: Icon(Icons.delete),
                                                      label: Text("Yes"),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
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
          ],
        ),
      ),
    );
  }
}
