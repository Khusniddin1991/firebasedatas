


import 'package:shared_preferences/shared_preferences.dart';

class Prefs{

  static  Future<bool> loadUser(String id) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString('user_id', id);

  }
  static Future<String > getUser()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString('user_id');

  }
  static  Future<bool> removeUser() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.remove('user_id');

  }






}