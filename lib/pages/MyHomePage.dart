import 'package:flutter/material.dart';
import 'package:pdponline/model/Post.dart';
import 'package:pdponline/services/FireData.dart';
import 'package:pdponline/services/Prefernce.dart';
import 'package:pdponline/services/auth.dart';

import 'DetailPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  static final String id='s';
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Post> items=List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiGetPost();
  }
 // get data fromanother page
  forApiNextPage()async{

    Map result=await Navigator.push(context, MaterialPageRoute(builder:(ctx)=>DetailPage()));
    if(result!=null||result.remove('data')){
      print(result["data"]);
      apiGetPost();
    }

   }

   // receive data from database
  apiGetPost()async {
    var id=await Prefs.getUser();
    RTDBService.getPost(id).then((posts) => {
      _posts(posts)
    });

  }

  // convert to object
  _posts(List<Post> posts){
    setState(() {
      items=posts;
    });
  }




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
        title: Text('add posts'),centerTitle: true,

      ),

      backgroundColor: Colors.white,
      body:Container(
          child:ListView.builder(itemCount: items.length,itemBuilder:(ctx,i){
            Post value=items[i];
            return Card(child: _makeIt(value),);
          })

      ),


      floatingActionButton: FloatingActionButton(
        onPressed: (){
          forApiNextPage();
        },
        child: Icon(Icons.add,),
        backgroundColor:Colors.purple ,

      ),

    );
  }
  Widget _makeIt(Post value) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(value.firstname.toString(),style: TextStyle(fontSize: 18),),
            SizedBox(width: 10,),
            Text(value.lastname.toString(),style: TextStyle(fontSize: 18),),
          ],),
          SizedBox(height: 10,),
          Text(value.content.toString(),style: TextStyle(fontSize: 18),),
          SizedBox(height: 10,),
          Text(value.data.toString(),style: TextStyle(fontSize: 18),),

        ],
      ),
    );




  }

}

