import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:n_hacker_news/Models/Story.dart';
import 'package:n_hacker_news/Screens/NewsPage.dart';
import 'package:n_hacker_news/Utils/NUtils.dart';

class NListAnimated extends StatelessWidget {
  final Story story;
  final String user;
  final String subtitle;
  final int score;
  final String intToDate;
  final String url;
  final bool onOffLine;

  final int index;
  final bool animatedListView;

  List<Color> listColor = [Colors.black, Colors.red, Colors.blue];

  NListAnimated({
    super.key,
    required this.index,
    required this.animatedListView,
    required this.user,
    required this.subtitle,
    required this.score,
    required this.intToDate,
    required this.url,
    required this.story,
    required this.onOffLine,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(
        animatedListView ? 0 : MediaQuery.of(context).size.width,
        0,
        0,
      ),
      duration: Duration(milliseconds: 300 + (index * 100)),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        // color: Theme.of(context).primaryColor,
      ),
      // Remove height property to allow the container's height to adjust based on content
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      child: ListTile(
        onLongPress: () {
          onOffLine == true ?
          showDialog(
              context: context,
              builder: (BuildContextcontext) {
                return AlertDialog(
                  title: Text(
                      "Voulez vous supprimer le dialog ? Reflichissez bien cette action est irreversible !"),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Disable'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Enable'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }) : null;
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsPage(
                url: url,
                story: story,
              ),
            ),
          );
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        // Add this to eliminate the ListTile padding
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(user.toUpperCase()), Text(intToDate)],
        ),

        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(subtitle.length > 30
                ? subtitle.substring(0, 20) + "...."
                : subtitle.substring(0, subtitle.length ~/ 2) + "...."),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                // color: Theme.of(context).colorScheme.tertiary,
              ),
              child: Row(
                children: [
                  onOffLine == true && story.isFavorite == false
                      ? Text("")
                      : Container(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(Icons.favorite),
                          ),
                        ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(score.toString()),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            ),
          ],
        ),
        leading: CircleAvatar(
          child: Text(NUtils.formatNameForProfile(user)),
          backgroundColor: NUtils.getRandomColor(),
          radius: 30,
        ),
      ),
    );

    /*
    return AnimatedContainer(
      transform: Matrix4.translationValues(
        animatedListView ? 0 : MediaQuery.of(context).size.width,
        0,
        0,
      ),
      duration: Duration(milliseconds: 300 + (index * 100)),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).primaryColor,
      ),
      height: 70, // Augmentez la hauteur de l'AnimatedContainer si nécessaire
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),

      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsPage(
                text: textTmp,
              ),
            ),
          );
        },
        contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 0), // Ajoutez cela pour éliminer le padding du ListTile

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Text(intToDate)],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(subtitle),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Theme.of(context).colorScheme.tertiary,
              ),
              child: Text("${score}"),
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            )
          ],
        ),

        leading: CircleAvatar(
          child: Text("UL"),
          backgroundColor: Color.fromARGB(255, 255, 200, 184),
          radius: 30,
        ),

        // trailing: CircleAvatar(
        //   radius: 25,
        //   child: IconButton(
        //     onPressed: () async {
        //       null;
        //     },
        //     icon: Icon(
        //       Icons.queue_music_rounded, color: Colors.black,
        //     ),
        //     iconSize: 30,
        //   ),
        // ),
      ),
    );
    */
  }
}
