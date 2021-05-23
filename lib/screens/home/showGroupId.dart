import 'package:flutter/services.dart';
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
                      padding: const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                              offset: Offset(4.0,4.0,),
                            )
                          ],
                        ),
                        child: Center(
                          child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.info_outline),
                                  iconSize: 15,
                                  onPressed: (){showInfo();},
                                ),
                                Text("Group ID: " + snapshot.data[1]),
                                IconButton(
                                  icon: Icon(Icons.copy),
                                  iconSize: 15,
                                  onPressed: (){copyToClipBoard(snapshot.data[1]);},
                                ),

                              ]
                          ),
                        ),

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

  copyToClipBoard(String textToCopy) {
    try {
      Clipboard.setData(ClipboardData(text: textToCopy));
      final snackBar = SnackBar(content: Text("Group ID copied to clipboard"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch(e) {
      print(e);
    }

  }

  void showInfo() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Group ID'),
        content: const Text('This Group ID defines your home\'s Id. Tap the copy Icon to send it to another member for them to join your group'),
        actions: <Widget>[

          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }




}