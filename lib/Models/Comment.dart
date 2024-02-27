class Comment {
  int? id;
  String? texte;
  int? storyId;
  String? userId;
  int? commentTime;

  Comment.fromJson(dynamic jsonData){
    id = jsonData['id'];
    texte = jsonData['texte'];
    storyId = jsonData['storyId'];
    userId = jsonData['userId'];
    commentTime = jsonData['commentTime'];
  }

  Map<String, dynamic> commentToJson() {

    Map<String, dynamic> map = {};
    map['id'] = id;
    map['texte'] = texte;
    map['storyId'] = storyId;
    map['userId'] = userId;
    map['commentTime'] = commentTime;

    return map;
  }
}