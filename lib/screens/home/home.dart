import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/screens/home/popMenu.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/screens/root/root.dart';
import 'file:///C:/Users/Razer/OneDrive/udemy/bellApp/flutter_firebaseapp/lib/screens/home/showGroupId.dart';
import 'package:qr_flutter/qr_flutter.dart';


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
          PopMenu(),

        ]
      ),
      body: ShowGroupId(),


    );
  }
}



