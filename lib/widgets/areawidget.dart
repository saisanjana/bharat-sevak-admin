import 'package:bharatsevakadmin/screens/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AreaWidget extends StatelessWidget {
  final String areaname;
  AreaWidget({@required this.areaname});
  void deletearea(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Are you sure to delete this Area?"),
              content: Text(
                  "Once you delete this area, all its services will be deleted"),
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
                        .collection("areas")
                        .document(areaname)
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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Services.routeName,arguments: {'areaname': areaname});
      },
          child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(media.width * 0.1))),
        elevation: 3,
        margin: EdgeInsets.only(
          left: media.width * 0.1,
          right: media.width * 0.1,
          top: media.width * 0.07,
        ),
        child: ListTile(
          title: Text(
            areaname,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onPressed: () {
                deletearea(context);
              }),
        ),
      ),
    );
  }
}
