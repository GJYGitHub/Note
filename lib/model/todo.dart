
class Todo{
 late int id=0;
 late String title;
 late String description;
 late String date;

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map['title']=this.title;
    map['description']=this.description;
    map['date']=this.date;
    return map;
  }

  Todo();

  Todo.fromMapObject(Map<String,dynamic> map){
    this.id=map['id'];
    this.title=map['title'];
    this.description=map['description'];
    this.date=map['date'];
  }
}