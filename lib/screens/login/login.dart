import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/screens/login/anonLoginForm.dart';
// import 'package:flutter_firebaseapp/screens/login/anonRingBellForm.dart';
import 'package:flutter_firebaseapp/screens/login/loginForm.dart';
import 'package:flutter/foundation.dart';
class OurLogin extends StatelessWidget {
  OurLogin({this.groupId});
  final String groupId;

  loginDecider(){

    if(!kIsWeb){
      return OurLoginForm();
    }
    else {
      debugPrint(groupId + "step 3"); // 3.14

      return OurAnonLoginForm(groupId: groupId,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 100, bottom: 30),
                      child: Image.asset("assets/qrbell.png"),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset("assets/bell.png"),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                loginDecider(),
              ],
            ),
          )
        ],
      ),

    );
  }
}