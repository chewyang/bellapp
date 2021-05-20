import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/models/user.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OurQrCode extends StatefulWidget {
  @override
  _OurQrCodeState createState() => _OurQrCodeState();
}

class _OurQrCodeState extends State<OurQrCode> {

  String groupId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR code for your home"),

      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: RepaintBoundary(
                child: QrImage(
                  data: "https://flutter-bellapp.web.app/" +getGroupId(),
                  size: 300.0,
                  version: 10,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
      ]),


    );
  }
    String getGroupId() {
      CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
      OurUser ourUser = _currentUser.getCurrentUser;
      return ourUser.groupId;
  }
}

