import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddService extends StatefulWidget {
  static const routeName = 'addserv';
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  int flag = 0;
  var areaname;
  void toggle() {
    setState(() {
      if (flag == 0) {
        flag = 1;
      } else {
        flag = 0;
      }
    });
  }

  void addArea() {
    if (flag == 1) {
       Firestore.instance
          .collection('areas')
          .document(areaname)
          .collection('products')
          .add(
        {
          'amount': int.parse(amount.text),
          'availability': availability.text,
          'description': description.text,
          'productName': name.text,
          'stock': int.parse(stock.text),
        },
      ).then((value) {
        Navigator.of(context).pop();
      });
      //print(ref);
    } else {
       Firestore.instance
          .collection('areas')
          .document(areaname)
          .collection('services')
          .add(
        {
          'amount': int.parse(amount.text),
          'availability': availability.text,
          'description': description.text,
          'serviceName': name.text,
          
        },
      ).then((value) {
        Navigator.of(context).pop();
      });
      //print(ref);
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController availability = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController stock = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final routeargs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    areaname = routeargs['areaname'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Service/Product"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Type:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RaisedButton(
                    onPressed: toggle,
                    child: Text("Service"),
                    color: flag == 0 ? Colors.green : Colors.grey,
                  ),
                  RaisedButton(
                    onPressed: toggle,
                    child: Text("Product"),
                    color: flag == 1 ? Colors.green : Colors.grey,
                  ),
                ],
              ),
              flag == 0
                  ? Container(
                      child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: "Service Name",
                        ),
                      ),
                    )
                  : Container(
                      child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: "Product Name",
                        ),
                      ),
                    ),
              Container(
                child: TextField(
                  controller: availability,
                  decoration: InputDecoration(
                    hintText: "availability",
                  ),
                ),
              ),
              Container(
                child: TextField(
                  controller: amount,
                  decoration: InputDecoration(
                    hintText: "Amount",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                child: TextField(
                  controller: description,
                  decoration: InputDecoration(
                    hintText: "Description",
                  ),
                ),
              ),
              flag==1?Container(
                child: TextField(
                  controller: stock,
                  decoration: InputDecoration(
                    hintText: "Stock",
                  ),
                ),
              ):Container(),
              Center(
                child: RaisedButton.icon(
                  onPressed: addArea,
                  icon: Icon(Icons.check),
                  label: Text("Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
