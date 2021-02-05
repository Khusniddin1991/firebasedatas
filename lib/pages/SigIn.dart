import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdponline/services/Prefernce.dart';
import 'package:pdponline/services/auth.dart';
import 'MyHomePage.dart';
import '../utilities/Utility.dart';
import 'SignUp.dart';

class SignIn extends StatefulWidget {
  static final String id='klkgf';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var isLoading=false;
  final _email=new TextEditingController();
  final _password=new TextEditingController();

  _doSignIn(){
    setState(() {
      isLoading=true;
    });
    String password=_password.text.trim().toString();
    String email=_email.text.trim().toString();
    if(email.isEmpty||password.isEmpty) return;
    FireBase.signIn(context, email, password).then((fireBase){
      print(fireBase);
      _getFireBase(fireBase);
    });

  }
  _getFireBase(FirebaseUser fireBase)async{
    setState(() {
      isLoading=false;
    });
    if(fireBase!=null){
      await Prefs.loadUser(fireBase.uid);

      Navigator.pushReplacementNamed(context,MyHomePage.id);
    }else{
      Utils.fireToast('check your email or password');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.grey,


                    )
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                obscureText: true,
                controller: _password,
                decoration: InputDecoration(

                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,


                    )
                ),
              ),
            ),
            SizedBox(height: 10,),


            Container(
              color: Colors.greenAccent,
              margin: EdgeInsets.symmetric(horizontal: 70),
              height: 50,
              width: double.infinity,
              child: FlatButton(
                onPressed: (){
                  _doSignIn();
                },
                child:Text('Sign In',style: TextStyle(
                  color: Colors.white,

                ),),
              ),
            )
            ,
            Container(
              padding: EdgeInsets.only(top: 10,left: 120),
              child: Row(
                children: [
                  Text("don't you have account",style: TextStyle(color: Colors.grey,fontSize: 17),),
                  SizedBox(width: 10,),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (ctx)=>SignUp()));
                      },
                      child: Text('SignUp',style: TextStyle(color: Colors.grey,fontSize: 15)))
                ],
              ),
            )
          ],
        ),
        isLoading?
        Center(child: CircularProgressIndicator(),):SizedBox.shrink()

      ],
      ),


    );
  }
}
