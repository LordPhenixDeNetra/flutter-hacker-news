import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NListAnimated extends StatelessWidget {
  final String title;
  final int index;
  final bool animatedListView;

  List<Color> listColor = [Colors.black, Colors.red, Colors.blue];

  NListAnimated({
    super.key,
    required this.title,
    required this.index,
    required this.animatedListView,
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
        color: Theme.of(context).primaryColor,
      ),
      height: 70, // Augmentez la hauteur de l'AnimatedContainer si nécessaire
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),

      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0), // Ajoutez cela pour éliminer le padding du ListTile

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("nullllllllllllllllllllllllll"), Text("12 fevr.")],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("nullllllllllllllll"),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Theme.of(context).colorScheme.tertiary,
              ),
            child: Text("165"),
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
  }
}



/*
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NListAnimated extends StatelessWidget {
  final String title;
  final int index;
  final bool animatedListView;

  List<Color> listColor = [Colors.black, Colors.red, Colors.blue];

  NListAnimated(
      {super.key,
      required this.title,
      required this.index,
      required this.animatedListView});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      
      transform: Matrix4.translationValues(
          animatedListView ? 0 : MediaQuery.of(context).size.width, 0, 0),
      duration: Duration(milliseconds: 300 + (index * 100)),
      curve: Curves.easeInOut,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).primaryColor,
      ),
      height: 60,
      // color: Theme.of(context).primaryColor,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),

      child: ListTile(
        leading: CircleAvatar(
            child: Text("UL"),
            backgroundColor: Color.fromARGB(255, 255, 200, 184),
            radius: 40,),

        title: Text("null"),
        subtitle: Text("null"),

        // trailing: Icon(Icons.play_arrow),
        trailing: CircleAvatar(
            radius: 25,
            child: IconButton(
              onPressed: () async {
                null;
              },
              icon: Icon(
                Icons.queue_music_rounded,
              ),
              iconSize: 30,
            )),
      ),
    );
  }
}
*/


