import 'package:flutter/material.dart';
import 'package:n_hacker_news/Models/Comment.dart';
import 'package:n_hacker_news/Models/Story.dart';
import 'package:n_hacker_news/Networking/HackerNewsAPI.dart';
import 'package:n_hacker_news/Utils/NUtils.dart';
import 'package:n_hacker_news/Widgets/NCommentList.dart';
import 'package:n_hacker_news/Widgets/NStoryWebView.dart';
import 'package:n_hacker_news/services/DatabaseHelperProvider.dart';
import 'package:provider/provider.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatelessWidget {
  final String url;
  final Story story;

  const NewsPage({super.key, required this.url, required this.story});

  @override
  Widget build(BuildContext context) {
    SolidController _controller = SolidController();
    final databaseHelper =
        Provider.of<DatabaseHelperProvider>(context, listen: false);

    
    IconData iconType = Icons.favorite_outline;

    return Scaffold(
      body: NWebView(
        url: url,
      ),
      bottomSheet: SolidBottomSheet(
        controller: _controller,
        draggableBody: true,
        canUserSwipe: true,
        minHeight: 100,
        maxHeight: 500,
        headerBar: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          // height: 130,
          height: 0,
          child: Center(
            child: Text("Les Commentaires"),
          ),
        ),
        body: Container(
          height: 30,
          child: Center(
              child: FutureBuilder(
                  future: HackerNewsAPI().getComments(story),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      print("Nombre de commentaire : ${snapshot.data!.length}");
                      print(
                          "ppppppppppppppppppppppppppppppppppppppppppppppppppppp");

                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int position) {
                            Comment comment = snapshot.data![position];
                            print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
                            print(snapshot.data![position].kids);
                            print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
                            print(snapshot.data![position].id);

                            return NCommentList(
                                // comment: snapshot.data![position],
                                commentateur: snapshot.data![position].userId ??
                                    "No Text",
                                commentTime:
                                    snapshot.data![position].commentTime ?? 0,
                                storyOwner: story.userId ?? "No Text",
                                text: NUtils.reformatText(
                                        snapshot.data![position].texte!) ??
                                    "No Text", 
                                    comment: snapshot.data![position], 
                                    // childs: snapshot.data![position].kids!.length,
                                    );
                          });
                    }
                  })),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   // child: Icon(Icons.stars),
      //   icon: Icon(Icons.comment),
      //   onPressed: () {
      //     _controller.isOpened ? _controller.hide() : _controller.show();
      //   },
      //   label: Text("Commentaires".toUpperCase()),
      // ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _controller.isOpened ? _controller.hide() : _controller.show();
            },
            child: Center(
              child: Icon(Icons.comment),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          FloatingActionButton(
            onPressed: () {
              databaseHelper.markArticleAsFavorite(story.id!);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("L'article est ajouter aux favories"),
                backgroundColor: Colors.green,
                dismissDirection: DismissDirection.up,
              ));
              // iconColor = Colors.red;
              iconType = Icons.favorite;
            },
            child: Icon(
              iconType,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog.fullscreen(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(story.title ?? "NO TEXT"),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    story.texte ??
                                        "L'article ne contient pas de Texte",
                                  ),
                                ],
                              ))
                        ],
                      ),
                    );
                  });
            },
            child: Icon(Icons.info),
          ),
        ],
      ),
    );
  }
}

class NWebView extends StatefulWidget {
  const NWebView({super.key, required this.url});

  final String url;

  @override
  State<NWebView> createState() => _NWebViewState();
}

class _NWebViewState extends State<NWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Web View"),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    if (await controller.canGoBack()) {
                      await controller.goBack();
                    } else {
                      messenger.showSnackBar(
                          SnackBar(content: Text("No Back History Found")));
                      return;
                    }
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              IconButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    if (await controller.canGoForward()) {
                      await controller.goForward();
                    } else {
                      messenger.showSnackBar(
                          SnackBar(content: Text("No Forward History Found")));
                      return;
                    }
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
              IconButton(
                  onPressed: () {
                    controller.reload();
                  },
                  icon: Icon(Icons.replay))
            ],
          )
        ],
      ),
      body: NStoryWebView(controller: controller),
    );
  }
}






/*

onPressed: () {
              // _controller.isOpened ? _controller.hide() : _controller.show();
              showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: MaterialLocalizations.of(context)
                      .modalBarrierDismissLabel,
                  barrierColor: Colors.blue,
                  transitionDuration: Duration(microseconds: 200),
                  pageBuilder: (BuildContext context, Animation first,
                      Animation seconds) {
                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 10,
                        height: MediaQuery.of(context).size.width - 10,
                        padding: EdgeInsets.all(20),
                        color: Colors.black,
                        child: Column(children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Exit"),
                            style: ButtonStyle(
                              backgroundColor:  MaterialStatePropertyAll<Color>(Colors.red),
                            ),
                          )
                        ]),
                      ),
                    );
                  });
            },



            */