class Story {
  int? id;
  int? descendants;
  String? title;
  String? texte;
  int? score;
  int? commentTime;
  String? url;
  String? userId;
  bool? isFavorite;
  List<int>? kids;

  Story({
    this.id,
    this.descendants,
    this.title,
    this.score,
    this.commentTime,
    this.url,
    this.userId,
    this.texte,
    this.isFavorite = false,
  });

  Story.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    descendants = jsonData['descendants'];
    title = jsonData['title'] ?? "L'article ne contient pas de Titre";
    score = jsonData['score'];
    commentTime = jsonData['time'];
    url = jsonData['url'] ?? "https://news.ycombinator.com";
    texte =
        reformatText(jsonData['text'] ?? "L'article ne contient pas de Texte");
    userId = jsonData['by'];
    kids = jsonData['kids'] != null ? List<int>.from(jsonData['kids']) : [];
  }

  factory Story.fromJsonData(Map<String, dynamic> jsonData) {
    return Story(
      id: jsonData['id'],
      descendants: jsonData['descendants'],
      title: jsonData['title'],
      score: jsonData['score'],
      commentTime: jsonData['time'],
      texte: jsonData['text'],
      url: jsonData['url'],
      userId: jsonData['by'],
    );
  }

  Map<String, dynamic> storyToJson() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['descendants'] = descendants;
    map['title'] = title;
    map['score'] = score;
    map['commentTime'] = commentTime; // Utiliser le nom correct de la colonne
    map['url'] = url;
    map['texte'] = texte;
    map['userId'] = userId;
    // map['kids'] = kids;
    return map;
  }

  List<int?> parseDynamicNumbers(List<dynamic> dynamics) {
    return dynamics
        .map((dynamics) => int.tryParse(dynamics.toString()))
        .where((num) => num != null)
        .toList();
  }

  List<int> parseList(dynamic val) {
    var kidSplited = val.toString().substring(1, val.length - 1).split(",");

    List<int> kids = [];
    for (var i in kidSplited) {
      kids.add(int.parse(i));
    }
    return kids;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descendants': descendants,
      'title': title,
      'score': score,
      'commentTime': commentTime,
      'url': url,
      'userId': userId,
      'text': texte,
      'isFavorite': isFavorite! ? 1 : 0,
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['id'],
      descendants: map['descendants'],
      title: map['title'],
      score: map['score'],
      commentTime: map['commentTime'],
      url: map['url'],
      texte: map['text'],
      userId: map['userId'],
      isFavorite: map['isFavorite'] == 1,
    );
  }

  String reformatText(String text) {
    // Supprimer les balises HTML
    String formattedText = text.replaceAll(RegExp(r'<[^>]*>'), '');

    // Décoder les entités HTML
    formattedText = formattedText.replaceAll('&quot;', '"');
    formattedText = formattedText.replaceAll('&amp;', '&');
    formattedText = formattedText.replaceAll('&lt;', '<');
    formattedText = formattedText.replaceAll('&gt;', '>');
    formattedText = formattedText.replaceAll('&apos;', '\'');
    formattedText = formattedText.replaceAll('&#x27;', '\'');

    return formattedText;
  }
}



/*
import 'dart:convert';

import 'package:n_hacker_news/Utils/NUtils.dart';

class Story {

  int? id;
  int? descendants;
  String? title;
  int? score;
  int? commentTime;
  String? url;
  String? userId;
  List<int>? kids;

  Story.fromJson(Map<String, dynamic> jsonData){
    id = jsonData['id'];
    descendants = jsonData['descendants'];
    title = jsonData['title'];
    score = jsonData['score'];
    commentTime = jsonData['time'];
    url = jsonData['url'];
    userId = jsonData['by'];
    kids = null;
    // kids = jsonData['kids'];
    
    // kids = parseDynamicNumbers(jsonData['kids']).cast<int>();
  }

  Map<String, dynamic> storyToJson() {

    Map<String, dynamic> map = {};
    map['id'] = id;
    map['descendants'] = descendants;
    map['title'] = title;
    map['score'] = score;
    map['time'] = commentTime;
    map['url'] = url;
    map['by'] = userId;

    return map;
  }

  List<int?> parseDynamicNumbers(List<dynamic> dynamics) {
    return dynamics
        .map((dynamics) => int.tryParse(dynamics.toString()))
        .where((num) => num != null)
        .toList();
  }

  List<int> parseList(dynamic val){

      var kidSplited =
          val.toString().substring(1, val.length - 1).split(",");

      List<int> kids = [];
      for (var i in kidSplited) {
        kids.add(int.parse(i));
      }

      return kids;
  }

}
*/
  /*

  Story copy({
    int? id,
    int? descendants,
    String? title,
    String? texte,
    int? score,
    int? commentTime,
    String? url,
    String? userId,
    bool? isFavorite,
  }) =>
      Story(
        id : id ?? this.id,
        descendants : descendants ?? this.descendants ,
        title : title ?? this.title,
        texte : texte ?? this.texte,
        score : score ?? this.score,
        commentTime : commentTime ?? this.commentTime,
        url : url ?? this.url,
        userId : userId ?? this.userId,
        isFavorite : isFavorite ?? this.isFavorite,
      );
  */