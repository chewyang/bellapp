import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/models/group.dart';
import 'package:flutter_firebaseapp/services/database.dart';

class CurrentGroup extends ChangeNotifier {
  OurGroup _currentGroup = OurGroup();

  OurGroup get getCurrentGroup => _currentGroup;

  void updateStateFromDatabase(String groupId) async {
    try{
      //get the group info from firebase
      _currentGroup = await OurDatabase().getGroupId(groupId);
      notifyListeners();
    } catch (e){
      print(e);
    }
  }

}