/*

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:n_hacker_news/Models/Story.dart';

class HackerNewsAPI {
  Future<List<int>> getTopStories() async {
    try {
      var request = await http
          .get(Uri.parse(
              "https://hacker-news.firebaseio.com/v0/topstories.json"))
          .timeout(Duration(seconds: 10));
      String response = request.body;
      var responseSplited =
          response.substring(1, response.length - 1).split(",");
      List<int> topStories = [];
      for (var i in responseSplited) {
        topStories.add(int.parse(i));
      }
      return topStories.sublist(0, topStories.length ~/ 100);
    } on TimeoutException {
      return [];
    } catch (e) {
      throw Exception('Failed to load top stories');
    }
  }

  Future<Story> getStoryById(int id) async {
    try {
      var request = await http
          .get(Uri.parse(
              "https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty"))
          .timeout(Duration(seconds: 10));
      var response = jsonDecode(request.body);
      return Story.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load story');
    }
  }

  Future<List<Story>> getAllStories() async {
    List<int> idStories = await getTopStories();
    List<Story> stories = [];

    for (var id in idStories) {
      Story story = await getStoryById(id);
      stories.add(story);
    }

    // for (var music in responseJson["data"]) {
    //   listMusic.add(Music.fromjson(music));
    // }

    return stories;
  }
}
*/




import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:n_hacker_news/Models/Comment.dart';
import 'package:n_hacker_news/Models/Story.dart';
import 'package:n_hacker_news/Models/SubComment.dart';

class HackerNewsAPI {
  static const String _baseUrl = "https://hacker-news.firebaseio.com/v0";

  Future<List<Story>> getAllStories() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/topstories.json")).timeout(Duration(seconds: 10));
      final List<int> topStoryIds = List<int>.from(jsonDecode(response.body));
      
      final List<Story> topStories = await Future.wait(topStoryIds.take(10).map((id) async {
        final storyResponse = await http.get(Uri.parse("$_baseUrl/item/$id.json"));
        final Map<String, dynamic> storyJson = jsonDecode(storyResponse.body);
        return Story.fromJson(storyJson);
      }));

      return topStories;
    } catch (e) {
      throw Exception('Failed to load top stories: $e');
    }
  }


/*
  Future<List<Comment>> getComments(Story story) async {
  try {
    final List<Comment> comments = [];
    if (story.kids != null) {
      for (int kidId in story.kids!) {
        final commentResponse =
            await http.get(Uri.parse("$_baseUrl/item/$kidId.json"));
        final Map<String, dynamic> commentJson =
            jsonDecode(commentResponse.body);
        if (commentJson['type'] == 'comment') {
          comments.add(Comment.fromJson(commentJson));
        }
      }
    }else if(story.kids == null){
      List<int> kids = await getKidsForArticle(story.id!);
      story.kids = kids;

      for (int kidId in story.kids!) {
        final commentResponse =
            await http.get(Uri.parse("$_baseUrl/item/$kidId.json"));
        final Map<String, dynamic> commentJson =
            jsonDecode(commentResponse.body);


        if (commentJson['type'] == 'comment') {
          comments.add(Comment.fromJson(commentJson));
        }
      }
      
    }
    return comments;
  } catch (e) {
    throw Exception('Failed to load comments: $e');
  }
*/

Future<List<Comment>> getComments(Story story) async {
  try {
    final List<int> kidsIds = story.kids ?? await getKidsForArticle(story.id!);

    // Récupérer les réponses de tous les appels en parallèle
    final List<http.Response> responses = await Future.wait(
      kidsIds.map((kidId) => http.get(Uri.parse("$_baseUrl/item/$kidId.json"))),
    );

    // Convertir les réponses JSON en objets Comment
    final List<Comment> comments = responses
        .map((response) => jsonDecode(response.body))
        .where((commentJson) => commentJson['type'] == 'comment')
        .map((commentJson) => Comment.fromJson(commentJson))
        .toList();

    return comments;
  } catch (e) {
    throw Exception('Failed to load comments: $e');
  }
}

/*

Future<List<SubComment>> getSubComments(Comment comment) async {
  try {
    final List<SubComment> subComments = [];
    if (comment.kids != null) {
      for (int kidId in comment.kids!) {
        final commentResponse =
            await http.get(Uri.parse("$_baseUrl/item/$kidId.json"));
        final Map<String, dynamic> subCommentJson =
            jsonDecode(commentResponse.body);
        if (subCommentJson['type'] == 'comment') {
          subComments.add(SubComment.fromJson(subCommentJson));
        }
      }
    } else {
      List<int> kids = await getKidsForComment(comment.id!);
      comment.kids = kids;

      for (int kidId in comment.kids!) {
        final commentResponse =
            await http.get(Uri.parse("$_baseUrl/item/$kidId.json"));
        final Map<String, dynamic> commentJson =
            jsonDecode(commentResponse.body);

        if (commentJson['type'] == 'comment') {
          subComments.add(SubComment.fromJson(commentJson));
        }
      }
    }
    return subComments;
  } catch (e) {
    throw Exception('Failed to load sub comments: $e');
  }
}
*/

Future<List<Comment>> getSubComments(Comment comment) async {
  try {
    final List<Comment> subComments = [];
    final List<int> kidsIds = comment.kids ?? await getKidsForComment(comment.id!);

    // Vérifier si kidsIds est null avant de l'utiliser
    if (kidsIds != null) {
      // Récupérer les réponses de tous les appels en parallèle
      final List<http.Response> responses = await Future.wait(
        kidsIds.map((kidId) => http.get(Uri.parse("$_baseUrl/item/$kidId.json"))),
      );

      // Convertir les réponses JSON en objets Comment
      for (final response in responses) {
        final commentJson = jsonDecode(response.body);
        if (commentJson['type'] == 'comment') {
          subComments.add(Comment.fromJson(commentJson));
        }
      }
    }

    return subComments;
  } catch (e) {
    throw Exception('Failed to load sub comments: $e');
  }
}


  Future<List<int>> getKidsForComment(int id) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/item/$id.json"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData.containsKey('kids')) {
          return List<int>.from(jsonData['kids']);
        }
      }
      // En cas d'absence de kids, retourner une liste vide
      return [];
    } catch (e) {
      throw Exception('Failed to fetch kids for comment $id: $e');
    }
  }




Future<List<int>>getKidsForArticle (int id) async {
    try {
      final request = await http.get(Uri.parse('https://hacker-news.firebaseio.com/v0/item/$id.json'));
      final List<int>listKids = [];
      if (request.statusCode == 200) {
        final article = Story.fromJson(json.decode(request.body));
        if (article.kids != null) {

          for (var kidId in article.kids!) {
            listKids.add(kidId);
            }
          }
        return listKids;
        }
      else {
        print('Erreur de requête pour l\'ID $id : ${request.statusCode}');
        return [];
      }
    } on TimeoutException {
      print('Timeout pour l\'ID $id');
      return [];
    } catch (e) {
      print('Erreur pour l\'ID $id : $e');
      return [];
    }

  }

}


/*

Future<List<SubComment>> getSubComments(Comment parentComment) async {
  try {
    final List<SubComment> subComments = [];

    if (parentComment.kids != null) {
      for (int kidId in parentComment.kids!) {
        final subCommentResponse =
            await http.get(Uri.parse("$_baseUrl/item/$kidId.json"));
        final Map<String, dynamic> subCommentJson =
            jsonDecode(subCommentResponse.body);

        if (subCommentJson['type'] == 'comment') {
          subComments.add(SubComment.fromJson({
            'id': subCommentJson['id'],
            'commentId': parentComment.id,
            'texte': subCommentJson['text'],
            'subCommentTime': subCommentJson['time'],
          }));
        }
      }
    }else if (parentComment.kids == null){

      List<int> kids = await getKidsForArticle(parentComment.id!);
      parentComment.kids = kids;

      for (int kidId in parentComment.kids!) {
        final subCommentResponse =
            await http.get(Uri.parse("$_baseUrl/item/$kidId.json"));
        final Map<String, dynamic> subCommentJson =
            jsonDecode(subCommentResponse.body);

        if (subCommentJson['type'] == 'comment') {
          subComments.add(SubComment.fromJson({
            'id': subCommentJson['id'],
            'commentId': parentComment.id,
            'texte': subCommentJson['text'],
            'subCommentTime': subCommentJson['time'],
          }));
        }
      }
    }

    return subComments;
  } catch (e) {
    throw Exception('Failed to load sub-comments: $e');
  }
}
*/


/*
Future<List<Comment>> getComments(Story story) async {
  try {
    final List<Comment> comments = [];

    if (story.kids != null) {
      final commentResponses = await Future.wait(story.kids!.map((kidId) async {
        final commentResponse =
            await http.get(Uri.parse("$_baseUrl/item/$kidId.json"));
        return commentResponse.body;
      }));

      for (final commentBody in commentResponses) {
        final Map<String, dynamic> commentJson = jsonDecode(commentBody);
        if (commentJson['type'] == 'comment') {
          comments.add(Comment.fromJson(commentJson));
        }
      }
    }

    return comments;
  } catch (e) {
    throw Exception('Failed to load comments: $e');
  }
}
*/


