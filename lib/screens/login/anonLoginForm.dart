import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:flutter_firebaseapp/widgets/ourContainer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/models/group.dart';
import 'package:flutter_firebaseapp/services/database.dart';

import 'package:flutter_firebaseapp/screens/groupRing.dart';



enum LoginType{
  anon,
}

class OurAnonLoginForm extends StatefulWidget {
  @override
  _OurAnonLoginFormState createState() => _OurAnonLoginFormState();
  OurAnonLoginForm({this.groupId});
  final String groupId;
}

class _OurAnonLoginFormState extends State<OurAnonLoginForm>{
  TextEditingController guestInfoController = TextEditingController();
  bool groupExist = false;


  Future sleep1() async {
    return await Future.delayed(Duration(seconds: 3));
  }

  void _loginAnon({@required LoginType type, String email, String password, BuildContext context}) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try{
      String returnString;
      switch(type){

        case LoginType.anon:
          await Future.delayed(Duration(seconds: 3));
          returnString = await _currentUser.signInAnon();
          break;
        default:
      }

      if(returnString == "success") {
        if(groupExist) {
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => OurGroupRing(groupId: guestInfoController.text,),), (route) => false
          // );
          final snackBar1 = SnackBar(content: Text("Doorbell successfully rang!"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar1);
        } else {
          final snackBar = SnackBar(content: Text("No such group exists!"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }

  }


  void sendAnonNotif(String groupId, String guestInfoText) async {
    _loginAnon(
        type: LoginType.anon,
        context: context
    );
    OurGroup groupInfo = await OurDatabase().getGroupInfo(groupId);
    if(groupInfo == null) {
      groupExist = false;
    } else {
      groupExist = true;
      OurDatabase().createNotifications( groupInfo.tokens ?? [],  widget.groupId, info: guestInfoText);
    }
  }



  @override
  Widget build(BuildContext context) {

    return new Column(
        children: <Widget>[

          OurContainer(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: guestInfoController,
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
                  onPressed: () async {
                    // groupIdController.text = widget.groupId;
                    await sendAnonNotif(widget.groupId, guestInfoController.text);
                  },
                ),
              ],
            ),
          ),
        ]
    );
  }


}