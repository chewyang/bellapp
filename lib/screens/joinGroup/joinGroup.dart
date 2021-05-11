import 'package:flutter_firebaseapp/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/services/database.dart';
import 'package:flutter_firebaseapp/screens/root/root.dart';

class OurJoinGroup extends StatefulWidget {
  @override
  OurJoinGroupState createState() => OurJoinGroupState();
}

class OurJoinGroupState extends State<OurJoinGroup> {

  void _joinGroup(BuildContext context, String groupId) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String retString = await OurDatabase().joinGroup(groupId, _currentUser.getCurrentUser.uid);
    if(retString == "success"){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OurRoot(),), (route) => false);
    }
  }

  TextEditingController groupIdController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      hintText: "Group Id",
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
                    onPressed: () => _joinGroup(context, groupIdController.text),
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