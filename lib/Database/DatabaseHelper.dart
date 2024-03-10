import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:n_hacker_news/Models/Story.dart';
import 'package:http/http.dart' as http;

class DatabaseHelper {
  // static final DatabaseHelper _instance = DatabaseHelper._internal();

  // factory DatabaseHelper() => _instance;

  // DatabaseHelper._internal();

  // late Database _db;

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('hackers.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  // Création de la table 'stories'
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE stories(
      id INTEGER PRIMARY KEY,
      descendants INTEGER,
      title TEXT,
      texte TEXT,
      score INTEGER,
      commentTime INTEGER,
      url TEXT,
      userId TEXT,
      isFavorite INTEGER
    )
  ''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  // Récupérer tous les articles de la base de données
  static Future<List<Story>> getStories() async {
    final db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query('stories');
    return List.generate(maps.length, (i) {
      return Story.fromMap(maps[i]);
    });
  }

  // Insérer un article dans la base de données
  static Future<int> insertStory(Story story) async {
    final db = await instance.database;
    return await db.insert('stories', story.storyToJson());
  }

  static Future<void> insertAllStories(List<Story> stories) async {
    try {
      for (var story in stories) {
        await insertOrUpdateStory(story);
      }
      print(
          'Toutes les histoires ont été insérées dans la base de données avec succès.');
    } catch (e) {
      print(
          'Une erreur s\'est produite lors de l\'insertion des histoires dans la base de données: $e');
    }
  }

  static Future<void> insertOrUpdateStory(Story story) async {
    // final db = await instance.database;

    bool articleExists = await isArticleAvailableLocally(story.id ??
        -1); // -1 est une valeur par défaut pour le cas où l'ID est null

    if (!articleExists) {
      // L'article n'existe pas localement, nous pouvons l'insérer
      await insertStory(story);
    } else {
      // L'article existe déjà localement, vous pouvez choisir de le mettre à jour ou de ne rien faire
      // Dans cet exemple, je ne fais rien
      print(
          'L\'article avec l\'ID ${story.id} existe déjà dans la base de données locale.');
    }
  }

  // Vérification de la disponibilité locale d'un article
  static Future<bool> isArticleAvailableLocally(int articleId) async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'stories',
      where: 'id = ?',
      whereArgs: [articleId],
    );
    return result.isNotEmpty;
  }

  // Marquage d'un article comme favori
  static Future<void> markArticleAsFavorite(int articleId) async {
    final db = await instance.database;
    await db.update(
      'stories',
      {'isFavorite': 1},
      where: 'id = ?',
      whereArgs: [articleId],
    );
  }
}
