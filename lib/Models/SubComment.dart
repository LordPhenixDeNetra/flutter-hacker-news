class SubComment {
  int? id;
  int? commentId;
  int? texte;
  int? subCommentTime;

  SubComment.fromJson(dynamic jsonData){
    id = jsonData['id'];
    commentId = jsonData['commentId'];
    texte = jsonData['texte'];
    subCommentTime = jsonData['subCommentTime'];
  }

  Map<String, dynamic> subCommentToJson() {

    Map<String, dynamic> map = {};
    map['id'] = id;
    map['commentId'] = commentId;
    map['texte'] = texte;
    map['subCommentTime'] = subCommentTime;

    return map;
  }
}