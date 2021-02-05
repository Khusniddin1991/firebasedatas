


class Post{
  String userId;
  String firstname;
  String lastname;
  String content;
  String data;

  Post({this.data,this.content,this.userId,this.firstname,this.lastname});

  Post.fromJson(Map<String,dynamic>json){
    this.data=json['title'];
    this.content=json['content'];
    this.userId=json['userId'];
    this.firstname=json['firstname'];
    this.lastname=json['lastname'];

  }
  Map<String,dynamic> toJson(){
    return {
      'firstname': this.firstname,
      'lastname': this.lastname,
      'title':this.data,
      'content':this.content,
      'userId':this.userId
    };
  }
















}