// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:n_hacker_news/Networking/HackerNewsAPI.dart';
import 'package:n_hacker_news/Widgets/NAppBar.dart';
import 'package:n_hacker_news/Widgets/NListAnimated.dart';
import 'package:n_hacker_news/constants/colors.dart';
import 'package:n_hacker_news/services/AnimationProvider.dart';
import 'package:n_hacker_news/services/ThemeProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final animationProvider = Provider.of<AnimationProvider>(context);

    return Scaffold(
      drawer: Drawer(),
      appBar: NAppBar(),
      body: Center(
          child: FutureBuilder(
              future: HackerNewsAPI().getTopStories()!,
              builder: (context, snapshot)
                  // builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot)
                  {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  // print(snapshot.data.toString());
                  // print(snapshot.data?.length);
                  // return Text(snapshot.data.toString());
                  animationProvider.setAnimatedListView();
                  bool animeted = animationProvider.animatedListView;

                  return ListView.builder(
                      
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int position) {
                        return NListAnimated(
                            title: snapshot.data![position].toString(),
                            index: position,
                            animatedListView: animeted);
                      });
                }
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightHeader,
        foregroundColor: Colors.white,
        onPressed: () {
          // themeProvider.toggleTheme();
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        },
        child: Icon(
          themeProvider.themeMode == ThemeMode.dark
              ? Icons.sunny
              : Icons.nightlight,
        ),
      ),
    );
  }
}



 /*
    return Material(
      child: FutureBuilder(
        future: HackerNewsAPI().getTopStories()!,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  CircularProgressIndicator();
          } else {
            print(snapshot.data.toString());
            return Text(snapshot.data.toString());

          }
      })
    );
    */

/**
 * 
 * 
 * 
 * Scaffold(

      drawer: Drawer(
      ),
      
      appBar: NAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightHeader,
        foregroundColor: Colors.white,
        onPressed: (){
          // themeProvider.toggleTheme();
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        },
        child: Icon(
          themeProvider.themeMode == ThemeMode.dark ? Icons.sunny : Icons.nightlight,
        ),
      ),
    );
 * 
 */
