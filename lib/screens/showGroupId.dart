import 'package:flutter/src/widgets/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/screens/root/root.dart';
import 'package:flutter_firebaseapp/services/database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_firebaseapp/models/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowGroupId extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ShowGroupId> {

  Future<String> showGroupId () async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String retString = await OurDatabase().getGroupId(_currentUser.getCurrentUser.uid);
    return retString;
    print(retString);
  }
  Future<List> getGroupmemberNames() async {
    String groupId = await showGroupId();
    List<String> memberIds = await OurDatabase().getGroupMemberIds(groupId);
    List<String> memberNames = await OurDatabase().getMemberNames(memberIds);
    return memberNames;
  }

  Future<String> sendNotif(String groupId) async {
    // CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    // String groupId = await OurDatabase().getGroupId(_currentUser.getCurrentUser.uid);
    OurGroup groupInfo = await OurDatabase().getGroupInfo(groupId);

    OurDatabase().createNotifications(groupInfo.tokens ?? [], groupId);
  }

  // create

  Widget build(BuildContext context) => FutureBuilder(
    // FutureBuilder(
      future: getGroupmemberNames(),
      builder:(context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(snapshot.data[index] + "ass");
                  }
              )
          );
        }
      }
  );


  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: FutureBuilder(
  //       future: showGroupId(),
  //       builder: (BuildContext context, snapshot){
  //         if(snapshot.connectionState == ConnectionState.waiting){
  //           return Center(child: Text("Loading...."),);
  //         } else {
  //           return Column(
  //             children: <Widget>[
  //               Spacer(flex:1,),
  //
  //               Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 40.0),
  //                 child: Text("Group ID: " + snapshot.data.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.grey[600])),
  //               ),
  //
  //               Spacer(flex: 1,),
  //               Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 20.0),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: <Widget>[
  //
  //                       RaisedButton(child: Text("Send notifications", style: TextStyle(color: Colors.white)), onPressed: (){sendNotif(snapshot.data.toString());},),
  //                     ],
  //                   )
  //               )
  //             ],);
  //         }
  //       },
  //     ),
  //   );
  // }
}