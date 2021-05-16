import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/models/group.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:flutter_firebaseapp/widgets/ourContainer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/services/database.dart';
import 'package:flutter_firebaseapp/screens/root/root.dart';

class OurGroupRing extends StatefulWidget {
  @override
  OurGroupRingState createState() => OurGroupRingState();
}

class OurGroupRingState extends State<OurGroupRing> {

  Future<String> sendNotif(String groupId) async {
    // CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    // String groupId = await OurDatabase().getGroupId(_currentUser.getCurrentUser.uid);
    OurGroup groupInfo = await OurDatabase().getGroupInfo(groupId);

    OurDatabase().createNotifications(groupInfo.tokens ?? [], groupId);
  }

  TextEditingController groupIdController = TextEditingController();



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
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: groupIdController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Id la jibai",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
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
                    onPressed: () => sendNotif(groupIdController.text),
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