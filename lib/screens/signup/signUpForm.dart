import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/widgets/ourContainer.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';

class OurSignUpForm extends StatefulWidget {
  @override
  _OurSignUpFormState createState() => _OurSignUpFormState();
}

class _OurSignUpFormState extends State<OurSignUpForm>{
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _signUpUser(String email, String password, BuildContext context, String fullName) async{
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try{
      String returnString = await _currentUser.signUpUser(email, password, fullName);
      if(returnString == "success"){ //if able to sign up the user then bring back to login screen
        Navigator.pop(context);
      } else{
        Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(returnString),
              duration: Duration(seconds: 2),
            ),
        );
      }
    } catch (e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)
              ),

            ),

            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(prefixIcon: Icon(Icons.person), hintText: "Full Name"),
            ),
            SizedBox(height: 20,),

            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(prefixIcon: Icon(Icons.alternate_email), hintText: "Email"),
            ),
            SizedBox(height: 20,), //just a padding between the 2 text forms

            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(prefixIcon: Icon(Icons.lock_outline), hintText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20,),

            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(prefixIcon: Icon(Icons.lock_open), hintText: "Confirm Password"),
              obscureText: true,
            ),
            SizedBox(height: 20,),

            RaisedButton(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
              ),
              onPressed: () {
                if(_passwordController.text == _confirmPasswordController.text){
                  _signUpUser(_emailController.text, _passwordController.text, context, _fullNameController.text);
                }
              } ,
            ), //Login button


          ]
      ),
    );
  }
}