import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/screens/login/login.dart';
import 'package:flutter_firebaseapp/screens/home/home.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/screens/splashScreen/splashScreen.dart';
import 'package:flutter_firebaseapp/screens/noGroup/noGroup.dart';




enum AuthStatus {
  unknown,
  notLoggedIn,
  notInGroup,
  inGroup
}

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.unknown;

  //when something within the dependencies change, this will be executed
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    //get the state, check current user, set AuthStatus based on state
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen:false);
    String returnString = await _currentUser.onStartUp();
    if(returnString == "success") {
      if(_currentUser.getCurrentUser.groupId != null){
        setState(() {
          _authStatus = AuthStatus.inGroup;
        });
      } else {
        setState(() {
          _authStatus = AuthStatus.notInGroup;
        });
      }

    } else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch(_authStatus) {
      case AuthStatus.unknown:
        retVal = OurSplashScreen();
        break;
      case AuthStatus.notLoggedIn:
        retVal = OurLogin();
        break;
      case AuthStatus.notInGroup:
        retVal = ourNoGroup();
        break;
      case AuthStatus.inGroup:
        retVal = HomeScreen();
        break;
    }

    return retVal;
  }
}
