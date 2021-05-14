import 'package:flutter/src/widgets/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/screens/root/root.dart';
import 'package:flutter_firebaseapp/services/database.dart';
import 'package:flutter_firebaseapp/screens/showGroupId.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class HomeScreen extends StatefulWidget {
  @override
  OurHomeScreenState createState() => OurHomeScreenState();
}

class OurHomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("This is home"),
        actions: <Widget>[
          FlatButton(
            child: Text("Sign out"),
            onPressed: () async {
              CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen:false);
              String returnString = await _currentUser.signOut();
              if(returnString == "success") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => OurRoot(),), (route) => false
                );
              }

            },
          )
        ]
      ),
      body: ShowGroupId(),
    );
  }
}



