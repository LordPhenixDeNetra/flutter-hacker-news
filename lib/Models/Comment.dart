import 'dart:convert';
import 'package:http/http.dart' as http;

class Comment {
  late int id;
  late String texte;
  late int storyId;
  late String userId;
  late int commentTime;
  List<int>? kids;

  Comment({
    required this.id,
    required this.texte,
    required this.storyId,
    required this.userId,
    required this.commentTime,
    this.kids,
  });

  Comment.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'] ?? 0;
    texte = jsonData['text'] ?? '';
    storyId = jsonData['parent'] ?? 0;
    userId = jsonData['by'] ?? '';
    commentTime = jsonData['time'] ?? 0;
    kids = jsonData['kids'] != null ? List<int>.from(jsonData['kids']) : null;
  }

  Map<String, dynamic> commentToJson() {
    return {
      'id': id,
      'texte': texte,
      'storyId': storyId,
      'userId': userId,
      'commentTime': commentTime,
      'kids': kids,
    };
  }

  Future<List<int>> getKids() async {
    if (kids != null) {
      return kids!;
    } else {
      return await fetchKids();
    }
  }

  Future<List<int>> fetchKids() async {
    try {
      final response = await http.get(Uri.parse("https://hacker-news.firebaseio.com/v0/item/$id.json"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData.containsKey('kids')) {
          return List<int>.from(jsonData['kids']);
        }
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch kids for comment $id: $e');
    }
  }

  Future<List<Comment>> getSubComments() async {
    final List<Comment> subComments = [];
    if (kids != null) {
      for (int kidId in kids!) {
        final commentResponse = await http.get(Uri.parse("https://hacker-news.firebaseio.com/v0/item/$kidId.json"));
        final Map<String, dynamic> subCommentJson = jsonDecode(commentResponse.body);
        if (subCommentJson['type'] == 'comment') {
          subComments.add(Comment.fromJson(subCommentJson));
        }
      }
    }
    return subComments;
  }
}