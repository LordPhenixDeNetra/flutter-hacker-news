import 'package:flutter/material.dart';
import 'package:n_hacker_news/Models/SubComment.dart';
import 'package:n_hacker_news/Models/Comment.dart';
import 'package:n_hacker_news/Networking/HackerNewsAPI.dart';
import 'package:n_hacker_news/Widgets/NCommentList.dart';

class SubCommentsPage extends StatelessWidget {
  final Comment comment;

  const SubCommentsPage({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Comments"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NCommentList(
              commentateur: comment.userId!,
              commentTime: comment.commentTime!,
              storyOwner: "storyOwner",
              text: comment.texte!, comment:  comment,
              // childs: 0,
            ),
            Container(
              child: FutureBuilder(
                future: comment.getSubComments(),
                builder: (context, AsyncSnapshot<List<Comment>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    print("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ");
                    print("NB Sub Comment : ${snapshot.data!.length}");
                    print(snapshot.data!);
                    print("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ");
                    
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int position) {
                        final subComment = snapshot.data![position];
                        return NCommentList(
                          commentateur: subComment.userId ?? "No Text",
                          commentTime: subComment.commentTime ?? 0,
                          storyOwner: subComment.userId ?? "No Text",
                          text: subComment.texte ?? "No Text", comment: comment,
                          //  childs: snapshot.data!.length,
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}







/*

import 'package:flutter/material.dart';
import 'package:n_hacker_news/Models/Comment.dart';
import 'package:n_hacker_news/Widgets/NCommentList.dart';

class SubCommentsPage extends StatelessWidget {
  final Comment comment;

  const SubCommentsPage({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Comments"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NCommentList(
              commentateur: comment.userId!,
              commentTime: comment.commentTime!,
              storyOwner: "storyOwner",
              text: comment.texte!,
              // comment: comment,
              // comment: null,
            ),
            Container(
              child: FutureBuilder(
                  future: comment.getSubComments(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      print("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ");
                      print("NB Sub Comment : ${snapshot.data!.length}");
                      print("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ");
                      print(snapshot.data!);
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int position) {
                            return NCommentList(
                              // comment: snapshot.data![position],
                              commentateur:
                                  snapshot.data![position].userId ?? "No Text",
                              commentTime:
                                  snapshot.data![position].commentTime ?? 0,
                              storyOwner:
                                  snapshot.data![position].userId ?? "No Text",
                              text: snapshot.data![position].texte ?? "No Text",
                              // comment: comment,
                            );
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

*/


/*
            FutureBuilder(
                  future: comment.getSubComments(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int position) {
                            print("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ");
                            print("NB Sub Comment : ${snapshot.data!.length}");
                            print("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ");
                            print(snapshot.data!);
                            return NCommentList(
                                // comment: snapshot.data![position],
                                commentateur: snapshot.data![position].userId ?? "No Text",
                                commentTime: snapshot.data![position].commentTime ?? 0,
                                storyOwner: snapshot.data![position].userId ?? "No Text",
                                text: snapshot.data![position].texte ?? "No Text", 
                                // comment: comment,
                          );
                          });
                    }
                  })
                  */
