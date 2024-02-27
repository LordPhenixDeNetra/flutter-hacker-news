class Story {

  int? id;
  int? descendants;
  String? title;
  int? score;
  int? commentTime;
  String? url;
  String? userId;

  Story.fromJson(dynamic jsonData){
    id = jsonData['id'];
    descendants = jsonData['descendants'];
    title = jsonData['title'];
    score = jsonData['score'];
    commentTime = jsonData['commentTime'];
    url = jsonData['url'];
    userId = jsonData['userId'];
  }

  Map<String, dynamic> storyToJson() {

    Map<String, dynamic> map = {};
    map['id'] = id;
    map['descendants'] = descendants;
    map['title'] = title;
    map['score'] = score;
    map['commentTime'] = commentTime;
    map['url'] = url;
    map['userId'] = userId;

    return map;
  }

}