
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pdponline/model/Post.dart';

class RTDBService{
  static final _database=FirebaseDatabase.instance.reference();

  static Future<Stream<Event>> addPost(Post post)async{
    _database.child("posts").push().set(post.toJson());
    return _database.onChildAdded;
  }
  static Future<List<Post>> getPost(String id) async{
    List<Post> items=new List();
    Query _query=_database.reference().child('posts').orderByChild('userId').equalTo(id);
    var snapshot=await _query.once();

    var result=snapshot.value.values as Iterable;
    for(var item in result){
      items.add(Post.fromJson(Map<String,dynamic>.from(item)));
    }

    return items;
  }


  static Future<Stream<Event>> update(Post post)async{
    print(post.toJson());
    await _database.child('posts').child('-MSfh5Zk20VsSVJkTiF6').update(post.toJson());
    return _database.onChildChanged;
  }

}










