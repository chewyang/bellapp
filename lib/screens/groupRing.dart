import 'dart:core';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/models/group.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:flutter_firebaseapp/widgets/ourContainer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/services/database.dart';
import 'package:flutter_firebaseapp/screens/root/root.dart';

import 'package:flutter_firebaseapp/screens/login/anonLoginForm.dart';

class OurGroupRing extends StatefulWidget {
  @override
  OurGroupRingState createState() => OurGroupRingState();

  const OurGroupRing({
    this.groupId,
    // this.child,
  });

  final String groupId;
  // final String child;
  String get getGroupId => groupId;
}

class OurGroupRingState extends State<OurGroupRing> {

  Future<void> sendNotif() async {
    OurGroup groupInfo = await OurDatabase().getGroupInfo(widget.groupId);

    OurDatabase().createNotifications(groupInfo.tokens ?? [], widget.groupId);
  }


  // }
  Widget loginDecider(){

    if(kIsWeb){
      debugPrint("web access bitch!");

      return OurAnonLoginForm(groupId: widget.groupId,);

    }
    else {
      debugPrint("app access bitch!");

      return OurRoot();

    }
  }


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
                      MaterialPageRoute(builder: (context) => loginDecider(),), (route) => false
                  );
                }

              },
            )
          ]
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          // projectWidget(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        "Join",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () => sendNotif(),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}