import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/screens/login/login.dart';
import 'package:flutter_firebaseapp/screens/login/loginForm.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:flutter_firebaseapp/utils/ourTheme.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebaseapp/screens/root/root.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String groupId;
  try {
    final String url = Uri.base.toString();
    groupId = url.substring(32);
    debugPrint(url);
    debugPrint(Uri.base.queryParameters['lanjiao']); // 3.14
    debugPrint(groupId); // 3.14
    log("jibaikia");
    runApp(MyApp(groupId: groupId,));

  } catch (e) {
    print(e);
    runApp(MyApp());

  }



}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp({this.groupId});
  final String groupId;
  @override
  Widget build(BuildContext context) {
    if(groupId == null) {
      return ChangeNotifierProvider(
        create: (context) => CurrentUser(), //the current user should have access to the whole app
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: OurTheme().buildTheme(),
          //: OurLogin(),

          home: OurRoot(),
          ),
    );
    } else {
      debugPrint(groupId + "step 2"); // 3.14
      return ChangeNotifierProvider(
        create: (context) => CurrentUser(), //the current user should have access to the whole app
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: OurTheme().buildTheme(),
          //: OurLogin(),

          home: OurLogin(groupId: groupId,),
        ),
      );
    }
  }


}


