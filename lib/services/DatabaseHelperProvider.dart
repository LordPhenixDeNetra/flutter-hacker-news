import 'package:flutter/material.dart';
import 'package:n_hacker_news/Database/DatabaseHelper.dart';
import 'package:n_hacker_news/Models/Story.dart';

class DatabaseHelperProvider extends ChangeNotifier {
  // final DatabaseHelper _databaseHelper = DatabaseHelper();


  // Récupérer tous les articles de la base de données
  Future<List<Story>> getAllArticles() async {
    return await DatabaseHelper.getStories();
  } 

  // Insérer un article dans la base de données
  Future<void> insertArticle(Story story) async {
    await DatabaseHelper.insertOrUpdateStory(story);
    notifyListeners();
  }

  // Insérer plusieurs articles dans la base de données
  Future<void> insertArticles(List<Story> stories) async {
    await DatabaseHelper.insertAllStories(stories); // Appel de la nouvelle méthode
    notifyListeners();
  }

  // Marquer un article comme favori
  Future<void> markArticleAsFavorite(int articleId) async {
    await DatabaseHelper.markArticleAsFavorite(articleId);
    notifyListeners();
  }

/*
  // Récupérer tous les articles de la base de données
  Future<List<Story>> getAllArticles() async {
    return await _databaseHelper.getStories();
  }

  // Marquer un article comme favori
  Future<void> markArticleAsFavorite(int articleId) async {
    await _databaseHelper.markArticleAsFavorite(articleId);
    notifyListeners();
  }

  // Supprimer un article de la base de données
  Future<void> deleteArticle(int articleId) async {
    await _databaseHelper.deleteArticle(articleId);
    notifyListeners();
  }
  */
}
