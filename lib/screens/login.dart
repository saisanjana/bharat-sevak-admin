import 'package:bharatsevakadmin/screens/nav_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  static const routeName ='abcd';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth mAuth;
  int flag = 0;
  int spin=1;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  
  void authenticate(String email, String password, BuildContext ctx)async {
    try {
     final res= await mAuth
          .signInWithEmailAndPassword(email: email, password: password);
          
            
        Navigator.pushReplacementNamed(context, NavScreen.routeName);

    }on PlatformException catch(err ) {
      //print(err.code);
      showDialog(
        context: ctx,
        builder: (ctx) => AlertDialog(
          title: Text("Login failed"),
          content: Text(err.message),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ok"),
            ),
          ],
        ),
      );
    }catch(err){
      showDialog(
        context: ctx,
        builder: (ctx) => AlertDialog(
          title: Text("Login failed"),
          content: Text("Tyr again after sometime"),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ok"),
            ),
          ],
        ),
      );
    }
  }

  /*void check() async {
    mAuth = FirebaseAuth.instance;
    setState(() {
      spin=0;
    });
    FirebaseUser user = await mAuth.currentUser();
    if (user != null) {
      Navigator.pushReplacementNamed(context, NavScreen.routeName);
    }
    setState(() {
      spin=1;
    });
  }*/
  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    mAuth = FirebaseAuth.instance;
    setState(() {
      spin=0;
    });
    FirebaseUser user = await mAuth.currentUser();
    if (user != null) {
      Navigator.pushReplacementNamed(context, NavScreen.routeName);
    }
    setState(() {
      spin=1;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 128, 0, 5),
              Color.fromRGBO(50, 205, 50, 5),
            ],
          ),
        ),
        child:spin==0?Center(child: CircularProgressIndicator(),): Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Card(
                      color: Colors.grey[350],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.account_box),
                        title: TextField(
                            controller: email,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.grey[350],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ListTile(
                        trailing: IconButton(
                            icon: Icon(flag == 0
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                flag == 0 ? flag = 1 : flag = 0;
                              });
                            }),
                        leading: Icon(Icons.lock),
                        title: TextField(
                            controller: password,
                            obscureText: flag == 0 ? true : false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        authenticate(email.text, password.text, context);
                      },
                      child: Text("Log In"),
                      color: Colors.green[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
