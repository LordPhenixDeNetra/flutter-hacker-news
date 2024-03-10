// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:n_hacker_news/Models/Story.dart';
import 'package:n_hacker_news/Networking/HackerNewsAPI.dart';
import 'package:n_hacker_news/Utils/NUtils.dart';
import 'package:n_hacker_news/Widgets/NAppBar.dart';
import 'package:n_hacker_news/Widgets/NListAnimated.dart';
import 'package:n_hacker_news/constants/colors.dart';
import 'package:n_hacker_news/services/AnimationProvider.dart';
import 'package:n_hacker_news/services/DatabaseHelperProvider.dart';
import 'package:n_hacker_news/services/ThemeProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final animationProvider = Provider.of<AnimationProvider>(context);
    
    final databaseHelper = Provider.of<DatabaseHelperProvider>(context, listen: false);

    print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
    // Appeler la méthode getAllArticles() pour vérifier si la base de données contient des données
    databaseHelper.getAllArticles().then((articles) {
      print('La base de données contient ${articles.length} articles');
    });
    print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");



    return Scaffold(
      drawer: Drawer(),
      appBar: NAppBar(),
      body: Center(
          child: FutureBuilder(
              future: HackerNewsAPI().getAllStories(),
              builder: (context, snapshot)
                  // builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot)
                  {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } 
                else {
                  animationProvider.setAnimatedListView();
                  bool animeted = animationProvider.animatedListView;
                  // final databaseHelper = Provider.of<DatabaseHelperProvider>(context);
                  List<Story> stories = snapshot.data!;

                  databaseHelper.insertArticles(stories);

                  int taille = snapshot.data!.length;
                  print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
                  print("Taille : ${taille}");
                  print("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int position) {
                        
                        print(snapshot.data![position].kids);
                        print(snapshot.data![position].id);

                        return Column(
                          children: [
                            NListAnimated(
                              url: snapshot.data![position].url ?? "No URL",
                              user: snapshot.data![position].userId ?? "No Text",
                              index: position,
                              animatedListView: animeted,
                              subtitle: snapshot.data![position].title! ?? "No Text",
                              score: snapshot.data![position].score ?? 0,
                              intToDate: NUtils.formatTimestamp(snapshot.data![position].commentTime ?? 0), 
                              story: snapshot.data![position], 
                              onOffLine: false, 
                            ),
                            Divider()
                          ],
                        );
                      });
                }
              })),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: lightHeader,
      //   foregroundColor: Colors.white,
      //   onPressed: () {
      //     // themeProvider.toggleTheme();
      //     Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      //   },
      //   child: Icon(
      //     themeProvider.themeMode == ThemeMode.dark
      //         ? Icons.sunny
      //         : Icons.nightlight,
      //   ),
      // ),
    );
  }
}

