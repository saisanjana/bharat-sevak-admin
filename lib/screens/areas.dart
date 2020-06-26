import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/areawidget.dart';

class Area extends StatefulWidget {
  @override
  _AreaState createState() => _AreaState();
}

class _AreaState extends State<Area> {
  void addArea(BuildContext ctx,{String givenname=""}) {
    TextEditingController name = TextEditingController();
    givenname!=""?
    Firestore.instance.collection('areas').document(givenname).setData({}).then((value) =>  
              Navigator.of(context).pop() )
    :
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Text("Add Area"),
        content: SingleChildScrollView(
          
          child: TextField(
            controller: name,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Area Name",
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.cancel),
            label: Text("Cancel"),
          ),
          FlatButton.icon(
            onPressed: () async {
               Firestore.instance.collection('areas').document('${name.text}').setData({}).then((value) =>  
              Navigator.of(context).pop() );   
            },
            icon: Icon(
              Icons.check,
            ),
            label: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Areas'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.arrow_downward), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.add_location),
            onPressed: () {
              addArea(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: StreamBuilder(
            stream: Firestore.instance.collection('areas').snapshots(),
            builder: (ctx, streamsnapshots) {
              if (streamsnapshots.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              List<dynamic> _lst = streamsnapshots.data.documents as dynamic;
              return ListView.builder(
                itemCount: streamsnapshots.data.documents.length,
                itemBuilder: (ctx, i) {
                  if (_lst[i].documentID != null) {
                    return AreaWidget(areaname: _lst[i].documentID);
                  }
                  return AreaWidget(areaname: "Error");
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
