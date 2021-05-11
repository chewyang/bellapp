import 'package:flutter/material.dart';

class OurTheme {
  Color _lightGreen = Color.fromARGB(255, 213, 235, 220);
  Color _lightGrey = Color.fromARGB(255, 164, 164, 164);
  Color _darkerGrey = Color.fromARGB(255, 119, 124, 135);


  ThemeData buildTheme(){
    return ThemeData(
      canvasColor: _lightGreen,
      primaryColor: _lightGreen,
      accentColor: _lightGrey,
      secondaryHeaderColor: _darkerGrey,
      hintColor: _lightGrey,

      inputDecorationTheme: InputDecorationTheme( //Makes the outline input border light grey
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
              color:_lightGrey
          ),
        ),

        focusedBorder: OutlineInputBorder( //This makes the outline input border turn green when pressed
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
              color:_lightGreen
          ),
        ),

      ),

      buttonTheme: ButtonThemeData( //This makes the button into a darker shade of grey and rounded off edges
        buttonColor: _darkerGrey,
        padding: EdgeInsets.symmetric(horizontal: 20),
        minWidth: 200,
        height: 40,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      )

    );
  }
}