import 'dart:async';

import 'package:http/http.dart' as http;

class HackerNewsAPI {
  Future<List<int>?> getTopStories() async {

    // List<int> topStories = [];

    try {
      var request = await http
        .get(Uri.parse(
            "https://hacker-news.firebaseio.com/v0/topstories.json"))
        .timeout(Duration(seconds: 10));

        String response = request.body;

        var responseSplited = response.substring(1, response.length - 1).split(",");
        List<int> topStories = [];

        for (var i in responseSplited) {
          topStories.add(int.parse(i));
        }

        return topStories;

    } on TimeoutException{
      return [];

    }catch (e) {
      
    }

    // return topStories;
  }
}
