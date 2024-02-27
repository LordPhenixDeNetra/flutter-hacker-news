// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database database;

  init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "news_DB");
    openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    String request = "CREATE TABLE();";
    await db.execute(request);
  }

  Future<int> _insertStories() async {}

  Future<int> _insertStories(Etudiant etudiant) async {
    //flushbar
    return await db.insert("Etudiant", etudiant.etudiantToJson());
  }
}
