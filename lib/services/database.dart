//interacts with firestore
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebaseapp/models/user.dart';
import 'package:flutter/services.dart';


class OurDatabase{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try {
      await _firestore.collection("users").document(user.uid).setData({
        'fullName': user.fullName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();

    try{
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").document(uid).get();
      retVal.uid = uid;
      retVal.fullName = _docSnapshot.data()["fullName"];
      retVal.email = _docSnapshot.data()["email"];
      retVal.accountCreated = _docSnapshot.data()["accountCreated"];
      retVal.groupId = _docSnapshot.data()["groupId"];
    } catch(e) {
      print(e);
    }
    return retVal;

  }

  Future<String> createGroup (String groupName, String userUid) async {
    String retVal = "error";
    List<String> members = List();
    try {
      members.add(userUid);
      DocumentReference _docRef = await _firestore.collection("groups").add({
        'name' : groupName,
        'leader' : userUid,
        'members' : members,
        'groupCreated' : Timestamp.now(),
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

  Future<String> joinGroup (String groupId, String userUid) async {
    String retVal = "error";
    List<String> members = List();
    try {
      members.add(userUid);
      await _firestore.collection("groups").document(groupId).update({
        'members': FieldValue.arrayUnion(members),
      });
      await _firestore.collection("users").document(userUid).update({
        'groupId' : groupId,
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

  



}