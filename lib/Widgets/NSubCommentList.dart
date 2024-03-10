import 'package:flutter/material.dart';
import 'package:n_hacker_news/Models/Comment.dart';
import 'package:n_hacker_news/Screens/SubCommentsPage.dart';
import 'package:n_hacker_news/Utils/NUtils.dart';

class NSubCommentList extends StatelessWidget {

  final Comment comment;

  const NSubCommentList({super.key, required this.comment, });

  @override
  Widget build(BuildContext context) {
     return Container(
      // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubCommentsPage(comment: comment),      
                ),
              );
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text( .toUpperCase()),
                // Text(NUtils.formatTimestamp(commentTime)),

                Text(comment.userId!),
                Text(NUtils.formatTimestamp(comment.commentTime!)),
              ],
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Text("En reponse à"),
                    SizedBox(
                      width: 15,
                    ),
                    // Text(storyOwner.toUpperCase()),
                    Text("storyOwner".toUpperCase()),
                  ],
                ),
                Text(
                  // text,
                  comment.texte!,
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(width: 2,),
                      Icon(Icons.comment),
                      Icon(Icons.share),
                      Icon(Icons.favorite_outline),
                    ])
              ],
            ),
            leading: CircleAvatar(
              child: Text(
                NUtils.formatNameForProfile(comment.userId!)
              ),
              backgroundColor: Color.fromARGB(255, 255, 200, 184),
              radius: 30,
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}