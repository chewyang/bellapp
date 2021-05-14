import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_firebaseapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebaseapp/services/database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CurrentUser extends ChangeNotifier{

  OurUser _currentUser = OurUser();

  OurUser get getCurrentUser => _currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp () async {
    String retVal = "error";

    try {
      User firebaseUser = await _auth.currentUser;
      if(firebaseUser != null) {
        _currentUser = await OurDatabase().getUserInfo(firebaseUser.uid); //_currentUser is a state in this case
       if (_currentUser != null)
          retVal = "success";
      }
    } catch (e) {
      print(e);
    }


    return retVal;
  }

  Future<String> signOut () async {
    String retVal = "error";

    try {
      await _auth.signOut();
      _currentUser = OurUser();
      retVal = "success";
    } catch (e) {
      print(e);
    }


    return retVal;
  }

  Future<String> signUpUser(String email, String password, String fullName)async{
    String retVal = "error";
    OurUser _user = OurUser();
    try{
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _user.uid = _authResult.user.uid;
      _user.email = _authResult.user.email;
      _user.fullName = fullName;
      // _user.notifToken = await _fcm.getToken();
      String _returnString = await OurDatabase().createUser(_user);
      if(_returnString == "success") {
        retVal = "success";
      }

      retVal = "success";


    } on PlatformException catch (e){
      retVal = e.message;
    } catch (e) {
      print(e);
    }

    return retVal;

  }

  Future<String> loginUserWithEmail(String email, String password)async{
    String retVal = "error";

    try{
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);

      _currentUser = await OurDatabase().getUserInfo(_authResult.user.uid); //_currentUser is a state in this case
      if(_currentUser != null)
        retVal = "success";

    } catch (e){
      retVal = e.message;
    }

    return retVal;
  }

  Future<String> loginUserWithGoogle()async{
    String retVal = "error";

    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    OurUser _user = OurUser();


    try{ //even if the user is a new user or old user, gets the info and if the state is not null then return a successful login
      GoogleSignInAccount _googleUser =  await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);

      UserCredential _authResult = await _auth.signInWithCredential(credential);

      if(_authResult.additionalUserInfo.isNewUser){
        _user.uid = _authResult.user.uid;
        _user.email = _authResult.user.email;
        _user.fullName = _authResult.user.displayName;
        // _user.notifToken = await _fcm.getToken();
        OurDatabase().createUser(_user);
      }

      _currentUser = await OurDatabase().getUserInfo(_authResult.user.uid); //_currentUser is a state in this case
      if(_currentUser != null)
        retVal = "success";

    } catch (e){
      retVal = e.message;
    }

    return retVal;
  }
}