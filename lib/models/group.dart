import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebaseapp/models/user.dart';

class OurGroup{
  String id;
  String name;
  String leader;
  List<OurUser> members;
  Timestamp groupCreated;
  List<String> tokens;

  OurGroup({
    this.id,
    this.name,
    this.leader,
    this.members,
    this.groupCreated,
    this.tokens,
  });

  OurGroup.fromDocumentSnapshot({DocumentSnapshot doc}) {
    id = doc.id;
    name = doc.data()["name"];
    leader = doc.data()["leader"];

    List<OurUser> users = [];
    List membersBefore = doc.data()["members"].toList();

    for (var user in membersBefore) {
      users.add(OurUser.fromJson(user));
    }
    members = users;

    tokens = List<String>.from(doc.data()["tokens"] ?? []);
    groupCreated = doc.data()["groupCreated"];

  }


}