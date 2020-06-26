

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        width: double.infinity,
        child: StreamBuilder(
          stream: Firestore.instance.collection('users').snapshots(),
          builder: (ctx, streamsnapshots) {
            if(streamsnapshots.connectionState==ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            List<dynamic> _lst =streamsnapshots.data.documents as dynamic;
            return ListView.builder(
              itemCount: streamsnapshots.data.documents.length,
              itemBuilder: (ctx, i) {
               if(_lst[i]['field']!=null){
                return ListTile(
                  title: Text('${_lst[i]['field']}'),
                );
                }
                return Text('User');
              },
            );
          },
        ),
      ),
    );
  }
}
