
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OurUser {
  String uid;
  String email;
  String fullName;
  Timestamp accountCreated;
  String groupId;
  String notifToken;

  OurUser({
    this.uid,
    this.email,
    this.fullName,
    this.accountCreated,
    this.groupId,
    this.notifToken,
  });

  OurUser.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.documentID;
    email = doc.data()['email'];
    accountCreated = doc.data()['accountCreated'];
    fullName = doc.data()['fullName'];
    groupId = doc.data()['groupId'];
    notifToken = doc.data()['notifToken'];
  }

}