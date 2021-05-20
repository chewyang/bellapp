import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/screens/login/login.dart';
import 'package:flutter_firebaseapp/screens/home/home.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/screens/splashScreen/splashScreen.dart';
import 'package:flutter_firebaseapp/screens/noGroup/noGroup.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import '../groupRing.dart';

// import 'dart:io';




enum AuthStatus {
  unknown,
  notLoggedIn,
  notInGroup,
  inGroup,
  anon
}

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.unknown;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    // if (Platform.isIOS) {
    //   _firebaseMessaging
    //       .requestNotificationPermissions(IosNotificationSettings());
    //   _firebaseMessaging.onIosSettingsRegistered.listen((event) {
    //     print("IOS Registered");
    //   });
    // }

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

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

    } else if (returnString == "success anon") {
      setState(() {
        _authStatus = AuthStatus.anon;
      });

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
      case AuthStatus.anon:
        retVal = OurGroupRing();
        break;
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
