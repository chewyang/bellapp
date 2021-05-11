import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/screens/root/root.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("This is home"),),
      body: Center (
          child:RaisedButton(
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

      ),
    );
  }
}
