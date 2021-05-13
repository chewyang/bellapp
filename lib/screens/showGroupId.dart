import 'package:flutter/src/widgets/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/screens/root/root.dart';
import 'package:flutter_firebaseapp/services/database.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: showGroupId(),
        builder: (BuildContext context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: Text("Loading...."),);
          } else {
            return Center(child:Text("Group Id: " + snapshot.data.toString()) ,);
          }
        },
      ),
    );
  }
}