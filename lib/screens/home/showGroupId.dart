import 'package:flutter/src/widgets/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/models/user.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:flutter_firebaseapp/widgets/ourContainer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/screens/root/root.dart';
import 'package:flutter_firebaseapp/services/database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_firebaseapp/models/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_firebaseapp/screens/home/listMember.dart';

class ShowGroupId extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ShowGroupId> {

  OurGroup groupInfo = OurGroup();
  OurUser currentUser = OurUser();
  List<OurUser> members = [];


  Future<String> showGroupId () async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    OurUser ourUser = _currentUser.getCurrentUser;
    this.currentUser = ourUser;
    return ourUser.groupId;
  }
  Future<OurGroup> getGroupInfo() async {
    String groupId = await showGroupId();
    this.groupInfo = await OurDatabase().getGroupInfo(groupId);
  }
  Future<List> getGroupmemberNames() async {
    await getGroupInfo();
    this.members = groupInfo.members;
    return await groupInfo.members;
  }


  Future<String> sendNotif(String groupId) async {
    OurGroup groupInfo = await OurDatabase().getGroupInfo(groupId);
    OurDatabase().createNotifications(groupInfo.tokens ?? [], groupId);
  }

  // create

  Widget build(BuildContext context) => FutureBuilder(


    // FutureBuilder(
      future: Future.wait([getGroupmemberNames(), showGroupId()]),
      builder:(context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          print("jus checking");
          return Column(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OurContainer(
                  child: Text("Group ID: " + snapshot.data[1]),

                ),
              ),
              Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: members.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {

                        return ListMember(members[index], groupInfo, currentUser, onDelete: () {removeItem(index);});
                      }
                  )
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: RaisedButton(
                    child: Text("Send notifications", style: TextStyle(color: Colors.white)),
                    onPressed: (){sendNotif(snapshot.data[1].toString());},
                  ),
                ),
              ),

            ],
          );
        }

      }

  );
  void removeItem( int index) {
    setState(() {
      print("hello bitch");
      //members = List.from(members)..removeAt(index);
    });
  }




}