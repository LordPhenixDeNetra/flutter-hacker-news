class UserSubmitted {
  int? id;
  int? submitted;
  String? userId;

  UserSubmitted.fromJson(dynamic jsonData){
    id = jsonData['id'];
    submitted = jsonData['submitted'];
    userId = jsonData['userId'];
  }

  Map<String, dynamic> userSubmittedToJson() {

    Map<String, dynamic> map = {};
    map['id'] = id;
    map['submitted'] = submitted;
    map['userId'] = userId;

    return map;
  }
}