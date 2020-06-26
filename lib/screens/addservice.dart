import 'package:flutter/material.dart';
class AddService extends StatefulWidget {
  static const routeName ='addserv';
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
 int flag=0;
 void toggle(){
   setState(() {
     if(flag==0){
       flag=1;
     }else{
       flag=0;
     }
   });
 }
  @override
  Widget build(BuildContext context) {
     final routeargs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    var areaname = routeargs['areaname'];
    return Scaffold(
      appBar: AppBar(
        title:Text("Add Service/Product"),
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Type:"),
              RaisedButton(onPressed: toggle,child:Text("Service"),color:flag==0?Colors.green:Colors.grey,),
              RaisedButton(onPressed: toggle,child:Text("Product"),color:flag==1?Colors.green:Colors.grey,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}