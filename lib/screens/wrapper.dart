import 'package:brew_app/screens/home_screen/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //return either home or authenticate widget, depending on log status
    return Home();
  }
}
