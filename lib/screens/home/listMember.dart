import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/models/group.dart';
import 'package:flutter_firebaseapp/models/user.dart';
import 'package:flutter_firebaseapp/services/database.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class ListMember extends StatelessWidget {

  OurUser user = OurUser(); //individual user for the focused menu card
  OurUser currentUser = OurUser();
  OurGroup group = OurGroup();
  final VoidCallback onDelete;

  ListMember(this.user, this.group, this.currentUser, {this.onDelete});

  Widget hellu (bool isLeader) {
      return FocusedMenuHolder(
        menuItems: focusMenuItem(isLeader),
        child: new Card(
          elevation: 7.0,
          child: new Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(6.0),
            child: new Row (
              children: <Widget>[
                new CircleAvatar(child: new Text(user.fullName[0]),),
                new Padding(padding: EdgeInsets.all(8.0)),
                new Text(user.fullName, style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
        ),
      );

  }

  List<FocusedMenuItem> focusMenuItem(bool isLeader) {
    if(isLeader) {
      return [
        FocusedMenuItem(title: Text("Remove from group"), onPressed: (){OurDatabase().leaveGroup(group.id, user); onDelete(); }, trailingIcon: Icon(Icons.exit_to_app)),
      ];
    } else {
      return [
        FocusedMenuItem(title: Text("wazzup"), onPressed: (){}, trailingIcon: Icon(Icons.emoji_emotions)),
      ];
    }
  }



  @override
  Widget build(BuildContext context) {
    bool isLeader = false;
    (currentUser.uid == group.leader)? isLeader = true : isLeader = false;

    return GestureDetector(
            onLongPress: (){
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("hi"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: hellu(isLeader),
          );
        }
  }




