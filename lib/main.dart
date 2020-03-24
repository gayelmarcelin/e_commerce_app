import 'package:ecommerceapp/pages/login.dart';
import 'package:ecommerceapp/pages/sign.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home: Login(),
    //home: LoginPage(),
  ));
}


