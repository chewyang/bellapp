

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/screens/root/root.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:provider/provider.dart';

class PopMenu extends StatefulWidget {
  @override
  _PopMenuState createState() => _PopMenuState();
}

class _PopMenuState extends State<PopMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: handleClick,
      itemBuilder: (BuildContext context) {
        return {'Sign Out', 'Settings'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  void handleClick(String value) async {
    switch (value) {
      case 'Sign Out':
        CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen:false);
        String returnString = await _currentUser.signOut();
        if(returnString == "success") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => OurRoot(),), (route) => false
          );
        }
        break;
      case 'Settings':
        break;
    }
  }
}
