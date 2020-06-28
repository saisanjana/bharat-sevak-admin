import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  static var rupee = String.fromCharCode(8377);
  static const routeName = 'details';
  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var lst = args['details'];
    var type = args['type'];
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(media.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              type == "product"
                  ? Text(
                      lst['productName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[300],
                        fontSize: media.height * 0.06,
                      ),
                    )
                  : Text(
                      lst['serviceName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[300],
                        fontSize: media.height * 0.06,
                      ),
                    ),
              SizedBox(
                height: media.height * 0.05,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Amount:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: media.height * 0.03,
                    ),
                  ),
                  SizedBox(
                    width: media.width * 0.02,
                  ),
                  CircleAvatar(
                    maxRadius: media.width * 0.07,
                    backgroundColor: Colors.green,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        rupee + '${lst['amount']}',
                        softWrap: false,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: media.height * 0.03,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: media.height * 0.05,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Availability:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: media.height * 0.03,
                    ),
                  ),
                  SizedBox(
                    width: media.width * 0.02,
                  ),
                  Text(
                    lst['availability'],
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: media.height * 0.03,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: media.height * 0.05,
              ),
              Text(
                "Description:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: media.height * 0.03,
                ),
              ),
              SizedBox(
                height: media.height * 0.02,
              ),
              Text(
                lst['description'],
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: media.height * 0.03,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
