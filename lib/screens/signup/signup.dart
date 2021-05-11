import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/screens/signup/signUpForm.dart';

class OurSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    BackButton(),
                  ],
                ),

                SizedBox(height: 40,),
                OurSignUpForm(),
              ],
            ),
          )
        ],
      ),

    );
  }
}