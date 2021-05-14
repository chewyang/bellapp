import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OurGroup{
  String id;
  String name;
  String leader;
  List<String> members;
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
    id = doc.documentID;
    name = doc.data()["name"];
    leader = doc.data()["leader"];
    members = List<String>.from(doc.data()["members"]);
    tokens = List<String>.from(doc.data()["tokens"] ?? []);
    groupCreated = doc.data()["groupCreated"];

  }

}