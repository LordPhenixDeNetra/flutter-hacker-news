class User {

  String? id;
  int? karma;
  int? created;

  User.fromJson(dynamic jsonData){
    id = jsonData['id'];
    karma = jsonData['karma'];
    created = jsonData['created'];
  }

  Map<String, dynamic> userToJson() {

    Map<String, dynamic> map = {};
    map['id'] = id;
    map['karma'] = karma;
    map['created'] = created;

    return map;
  }

}




