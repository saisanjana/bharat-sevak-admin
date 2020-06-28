
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './login.dart';
class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
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
  void deleteuser(BuildContext context,var lst) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Are you sure to delete this User?"),
              content: Text(
                  "Once you delete this user, all his details and orders will be deleted"),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.cancel),
                  label: Text("Cancel"),
                ),
                FlatButton.icon(
                  onPressed: () {
                    Firestore.instance
                        .collection("users")
                        .document(lst.documentID)
                        .delete()
                        .then(
                      (value) {
                        Navigator.of(context).pop();
                        print("Deleted");
                      },
                    );
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                  label: Text("Delete"),
                ),
              ],
            ));
  }
  Future<Widget> showdetails(var lst, BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx)=>AlertDialog(
        title: Text('${lst['name']}'),
        content: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child: Text("User ID: "+'${lst.documentID}')),
              Container(child: Text("Name :"+ '${lst['name']}' )),
              Container(child: Text("Phone: "+ '${lst['phone']}')),
              Container(child: Text("Email: "+ '${lst['Email']}')),
            ],
          ),
        ),
        actions: <Widget>[
          RaisedButton(onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text('OKAY'),),
        ],
      ),
    );
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
          : Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder(
                stream: Firestore.instance.collection('users').snapshots(),
                builder: (ctx, snaps) {
                  if (snaps.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<dynamic> lst = snaps.data.documents as dynamic;
                  return ListView.builder(
                    itemCount: lst.length,
                    itemBuilder: (ctx, i) {
                      return GestureDetector(
                        onTap: () => showdetails(lst[i],context),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: ListTile(
                            leading: Icon(Icons.account_box),
                            title: Text(lst[i]['name']),
                            trailing: IconButton(
                                icon: Icon(Icons.delete), onPressed: () {
                                  deleteuser(context, lst[i]);
                                }),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
