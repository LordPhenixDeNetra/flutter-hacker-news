class SubComment {
  int? id;
  int? commentId;
  String? userId;
  String? texte;
  int? subCommentTime;

  SubComment({
    required this.id,
    required this.commentId,
    required this.userId,
    required this.texte,
    required this.subCommentTime,
  });

  SubComment.fromJson(Map<String, dynamic> jsonData){
    id = jsonData['id'];
    commentId = jsonData['parent'];
    texte = jsonData['text'];
    subCommentTime = jsonData['time'];
    userId = jsonData['by'];
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