import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdponline/pages/SigIn.dart';

import 'Prefernce.dart';

class FireBase{

  static final auth=FirebaseAuth.instance;

  static Future<FirebaseUser> signIn (BuildContext context, String email ,String password)async{
    try{
      auth.signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user=await auth.currentUser();
      print(user.toString());
      return user;
    }catch(e){
      print(e);
    }

    return null;


  }
  static Future<FirebaseUser> signUP (BuildContext context,String name , String email ,String password)async{
    try{
      var authresult= await auth.createUserWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user=await authresult.user;
      print(user);
      return user;
    }catch(e){
      print(e);
    }

    return null;


  }

  static void signout(BuildContext context){
    auth.signOut();
    Prefs.removeUser().then((value) => {
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(ctx)=>SignIn()))

    });
  }

}