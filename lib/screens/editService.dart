import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditService extends StatefulWidget {
  static const routeName = 'detail';

  @override
  _EditServiceState createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  void edit(BuildContext context,String type,String area,var lst) {
    /*print(name);
    print(amount);
    print(availability);
    print(description);
    print(stock);*/
    if(type=="product"){
      Firestore.instance.collection('areas').document(area).collection('products').document(lst.documentID).setData({
        'productName':name==""?lst['productName']:name,
        'amount':amount==""?lst['amount']:int.parse(amount),
        'availability':availability==""?lst['availability']:availability,
        'description':description==""?lst['description']:description,
        'stock':stock==""?lst['stock']:int.parse(stock),
      }).then((value) => {
        Navigator.of(context).pop()
      });
    }else{
      Firestore.instance.collection('areas').document(area).collection('services').document(lst.documentID).setData({
        'serviceName':name==""?lst['serviceName']:name,
        'amount':amount==""?lst['amount']:int.parse(amount),
        'availability':availability==""?lst['availability']:availability,
        'description':description==""?lst['description']:description,
        
      }).then((value) => {
        Navigator.of(context).pop()
      });

    }

  }
  String name="";
  String amount="";
  String availability="";
  String description="";
  String stock="";
  
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final type = args['type'];
    final lst = args['details'];
    final area = args['area'];
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: Container(
        height: media.height,
        padding: EdgeInsets.all(media.width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextFormField(
                onChanged: (v){
                  name=v;
                },
                initialValue:
                    type == "product" ? lst['productName'] : lst['serviceName'],
                decoration: InputDecoration(
                  labelText:
                      type == "product" ? "Product Name" : "SErvice Name",
                ),
              ),
              TextFormField(
                onChanged: (v){
                  amount=v;
                },
                initialValue: lst['amount'].toString(),
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
              ),
              TextFormField(
                onChanged: (v){
                  availability=v;
                },
                initialValue: lst['availability'],
                decoration: InputDecoration(
                  labelText: "Availability",
                ),
              ),
              TextFormField(
                onChanged: (v){
                  description=v;
                },
                initialValue: lst['description'],
                decoration: InputDecoration(
                  labelText: "Description",
                ),
              ),
              type=="product"?TextFormField(
                onChanged: (v){
                  stock=v;
                },
                initialValue: lst['stock'].toString(),
                decoration: InputDecoration(
                  labelText: "Stock",
                ),
              ):Container(),
              RaisedButton.icon(
                onPressed: () {
                  edit(context,args['type'],area,lst);
                },
                icon: Icon(Icons.check),
                label: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
