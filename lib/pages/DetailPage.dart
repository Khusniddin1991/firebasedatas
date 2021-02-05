import 'package:flutter/material.dart';
import 'package:pdponline/model/Post.dart';
import 'package:pdponline/services/FireData.dart';
import 'package:pdponline/services/Prefernce.dart';
import 'package:pdponline/services/auth.dart';
class DetailPage extends StatefulWidget {
  @override
  static final String id='DetailPage';
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final _content=new TextEditingController();
  final _data=new TextEditingController();
  final _firstname=new TextEditingController();
  final _lastname=new TextEditingController();
  _addPost()async{
    String content=_content.text.trim().toString();
    String data=_data.text.trim().toString();
    String firstname=_firstname.text.trim().toString();
    String lastname=_lastname.text.trim().toString();
    var id=await Prefs.getUser();
    RTDBService.addPost(new Post(userId: id,content: content,firstname:firstname,lastname:lastname,data: data
    )).then((value) =>{
      print(value)});
    _readIt();

  }
  _readIt()async {
    Navigator.of(context).pop({'data': 'done'});
  }

  // final _conten=new TextEditingController();
  // final _titl=new TextEditingController();
  // _updatePost()async{
  //   String content=_conten.text.trim().toString();
  //   String title=_titl.text.trim().toString();
  //   print(content);
  //   var id=await Prefs.getUser();
  //   RTDBService.update(new Post(userId:id,content:content,)).then((value) =>{
  //     print(value)
  //   });
  //
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app,color: Colors.white,), onPressed:(){
            FireBase.signout(context);
          })
        ],
        title: Text('Home'),centerTitle: true,
      ),

      backgroundColor: Colors.white,
      body:Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child:Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              TextField(
                controller: _firstname,
                decoration: InputDecoration(
                    hintText: 'First Name'
                ),
              ),SizedBox(height: 10,),
              TextField(
                controller: _lastname,
                decoration: InputDecoration(
                    hintText: 'Last name'
                )),SizedBox(height: 10,),
              TextField(
                controller: _content,
                decoration: InputDecoration(
                    hintText: 'Content'
                ),
              ),SizedBox(height: 10,),
                TextField(
                  controller: _data,
                  decoration: InputDecoration(
                      hintText: 'Data'
                  ),
              ),SizedBox(height: 10,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 80),
                height: 50,
                color: Colors.green,
                child: FlatButton(
                  onPressed: (){
                    _addPost();
                  }
                  ,child: Text('add',style: TextStyle(color: Colors.white),),
                ),
              ),
               SizedBox(height: 10,),
              // Container(
              //   width: double.infinity,
              //   margin: EdgeInsets.symmetric(horizontal: 80),
              //   height: 50,
              //   color: Colors.green,
              //   child: FlatButton(
              //     onPressed: (){
              //       _updatePost();
              //     }
              //     ,child: Text('Update',style: TextStyle(color: Colors.white),),
              //   ),
              // )


            ],
          )

      ),
    );
  }
}
