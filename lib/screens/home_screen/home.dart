import 'package:brew_app/screens/home_screen/brew_list.dart';
import 'package:brew_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_app/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  //Creating an instance of AuthService() class
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brewaholic'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text('Logout'),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
