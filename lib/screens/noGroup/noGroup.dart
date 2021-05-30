import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/screens/joinGroup/joinGroup.dart';
import 'package:flutter_firebaseapp/screens/createGroup/createGroup.dart';


class ourNoGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _goToJoin(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context) => OurJoinGroup(),), );
    }
    void _goToCreate(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context) => OurCreateGroup(),), );
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          Spacer(flex:1,),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 40, right: 10, top: 100, bottom: 30),
                child: Image.asset("assets/qrbell.png"),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: Image.asset("assets/bell.png"),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text("Welcome", textAlign: TextAlign.center, style: TextStyle(fontSize: 40, color: Colors.grey[600])),
          ),

          Padding(
            padding: EdgeInsets.all( 20.0),
            child: Text("Since you are not registered to a home , you can select either to join a home or create a home group.", textAlign: TextAlign.center ,style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          ),
          Spacer(flex: 1,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Create"),
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Theme.of(context).secondaryHeaderColor, width: 2,),
                  ),
                  onPressed: ()=> _goToCreate(context),
                ),
                RaisedButton(child: Text("Join", style: TextStyle(color: Colors.white)), onPressed: ()=> _goToJoin(context),),
              ],
            )
          )
      ],)
    );
  }
}
