import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



import 'package:pdponline/pages/DetailPage.dart';
import 'package:pdponline/pages/SigIn.dart';
import 'package:pdponline/pages/SignUp.dart';
import 'package:pdponline/services/Prefernce.dart';

import 'pages/MyHomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget _startPage(){
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context ,snapshot){
          if(snapshot.hasData){
            Prefs.loadUser(snapshot.data.uid);
            return MyHomePage();
          }
            else{
              Prefs.removeUser();
              return SignIn();
          }
        }

    );



  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignIn.id:(ctx)=>SignIn(),
        MyHomePage.id:(ctx)=>MyHomePage(),
        SignUp.id:(ctx)=>SignUp(),
        DetailPage.id:(ctx)=>DetailPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _startPage(),
    );
  }
}


