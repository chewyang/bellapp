//interacts with firestore
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebaseapp/models/user.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebaseapp/models/group.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class OurDatabase{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseMessaging _fcm = FirebaseMessaging();


  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try {
      //_fcm.de;
      await _firestore.collection("users").document(user.uid).setData({
        'fullName': user.fullName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
        'notifToken': await _fcm.getToken(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal;

    try{
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").document(uid).get();
      retVal = OurUser.fromDocumentSnapshot(doc: _docSnapshot);
    } catch(e) {
      print(e);
    }
    return retVal;

  }

  Future<String> createGroup (String groupName, String userUid) async {




    String retVal = "error";
    List<String> members = List();
    List<String> tokens = List();

    try {
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").document(userUid).get();
      String userToken =  _docSnapshot.data()["notifToken"];

      members.add(userUid);
      tokens.add(userToken);
      DocumentReference _docRef = await _firestore.collection("groups").add({
        'name' : groupName,
        'leader' : userUid,
        'members' : members,
        'groupCreated' : Timestamp.now(),
        'tokens': tokens,
      });

      await _firestore.collection("users").document(userUid).update({
        'groupId' : _docRef.documentID,
      });

      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> joinGroup (String groupId, OurUser user) async {
    String retVal = "error";
    List<String> members = List();
    List<String> tokens = List();

    try {
      members.add(user.uid);
      tokens.add(user.notifToken);

      // DocumentSnapshot _docSnapshot = await _firestore.collection("users").document(user.uid).get();
      // String userToken =  _docSnapshot.data()["notifToken"].toString();


      await _firestore.collection("groups").document(groupId).update({
        'members': FieldValue.arrayUnion(members),
        'tokens': FieldValue.arrayUnion(tokens),
      });
      await _firestore.collection("users").document(user.uid).update({
        'groupId' : groupId.trim(),
      });

      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> getGroupId (String uid) async {
    String groupId;
    try{
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").document(uid).get();
      groupId = _docSnapshot.data()["groupId"];
    } catch(e) {
      print(e);
    }
    return groupId;

  }


  Future<OurGroup> getGroupInfo(String groupId) async {
    OurGroup retVal;

    try{
      DocumentSnapshot _docSnapshot = await _firestore.collection("groups").document(groupId).get();
      retVal = OurGroup.fromDocumentSnapshot(doc: _docSnapshot);
    } catch(e) {
      print(e);
    }
    return retVal;

  }


  Future<String> createNotifications(List<String> tokens, String groupId) async {
    String retVal = "error";

    try{
      await _firestore.collection("notifications").add({
        'tokens': tokens,
        'groupId': groupId
      });
      retVal = "success";

    } catch(e) {
      print(e);
    }
    return retVal;

  }



}