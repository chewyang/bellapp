
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
    uid = doc.id;
    email = doc.data()['email'];
    accountCreated = doc.data()['accountCreated'];
    fullName = doc.data()['fullName'];
    groupId = doc.data()['groupId'];
    notifToken = doc.data()['notifToken'];
  }

  Map<String, dynamic> toJson() =>
      {
        'accountCreated': this.accountCreated,
        'email': this.email,
        'fullName': this.fullName,
        'notifToken': this.notifToken,
        'uid': this.uid,
      };

  OurUser.fromJson(Map parsedJson)
    : uid = parsedJson['uid'],
     email = parsedJson['email'],
    fullName = parsedJson['fullName'],
    accountCreated = parsedJson['accountCreated'],
    notifToken = parsedJson['notifToken'];


}