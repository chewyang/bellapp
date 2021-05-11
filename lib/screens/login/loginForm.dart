import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/widgets/ourContainer.dart';
import 'package:flutter_firebaseapp/screens/signup/signup.dart';
import 'package:flutter_firebaseapp/states/currentUser.dart';
import 'package:flutter_firebaseapp/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebaseapp/screens/noGroup/noGroup.dart';
import 'package:flutter_firebaseapp/screens/root/root.dart';

enum LoginType{
  email,
  google,
}

class OurLoginForm extends StatefulWidget {
  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm>{
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _loginUser({@required LoginType type, String email, String password, BuildContext context}) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    
    try{
      String returnString;
      switch(type){

        case LoginType.email:
          returnString = await _currentUser.loginUserWithEmail(email, password);
          break;

        case LoginType.google:
          returnString = await _currentUser.loginUserWithGoogle();
          break;
        default:
      }

      if(returnString == "success"){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => OurRoot(),), (route) => false
        );

      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    
  }

  Widget _googleButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        _loginUser(
            type: LoginType.google,
            context: context
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new OurContainer(
      child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Text(
                  "Log In",
                  style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)
              ),

            ),
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


            RaisedButton(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                ),
              onPressed: () {
                  _loginUser(
                      type: LoginType.email,
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context
                  );
              } ,
            ), //Login button

            FlatButton(
              child:Text("Dont have a pussy? Get one here"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OurSignUp()),);
              },
            ),
            _googleButton()

          ]
      ),
    );
  }


}