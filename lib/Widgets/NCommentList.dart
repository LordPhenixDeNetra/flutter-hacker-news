import 'package:flutter/material.dart';
import 'package:n_hacker_news/Models/Comment.dart';
import 'package:n_hacker_news/Screens/SubCommentsPage.dart';
import 'package:n_hacker_news/Utils/NUtils.dart';

class NCommentList extends StatelessWidget {
  final String commentateur;
  final int commentTime;
  final String storyOwner;
  final String text;
  // final int childs;

  final Comment comment;

  const NCommentList({
    super.key,
    required this.commentateur,
    required this.commentTime,
    required this.storyOwner,
    required this.text,
    required this.comment,
    // required this.childs,
    // required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final Comment comment = Comment(
        id: 0,
        texte: text,
        storyId: 0,
        userId: commentateur,
        commentTime: commentTime);

    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        // color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubCommentsPage(
                    comment: comment,
                  ),

                  // builder: (context) => SubCommentPage(
                  //   commentateur: commentateur,
                  //   commentTime: commentTime,
                  //   storyOwner: storyOwner,
                  //   text: text,
                  // ),
                ),
              );
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(commentateur.toUpperCase()),
                Text(NUtils.formatTimestamp(commentTime)),
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
                  text,
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(width: 2,),
                      Row(
                        children: [Icon(Icons.comment), Text("")],
                      ),
                      Icon(Icons.share),
                      Icon(Icons.favorite_outline),
                    ])
              ],
            ),
            leading: CircleAvatar(
              child: Text(NUtils.formatNameForProfile(commentateur)),
              backgroundColor: NUtils.getRandomColor(),
              radius: 30,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}


/*    */
