import 'package:flutter/material.dart';
import 'package:n_hacker_news/Widgets/BottomSheetDummyUI.dart';
import 'package:n_hacker_news/Widgets/NBottomSheet.dart';
import 'package:n_hacker_news/Widgets/NBottomSheet2.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    SolidController _controller = SolidController();

    return Scaffold(
      // body: NBottomSheet2(
      //     child: Column(
      //   children: [
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //     BottomSheetDummyUI(),
      //   ],
      // )
      //),

      bottomSheet: SolidBottomSheet(
        headerBar: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          // color: Theme.of(context).primaryColor,
          height: 50,
          child: Center(
            child: Text("Swipe me!"),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: 30,
          child: Center(
            child: Text(
              "Hello! I'm a bottom sheet :D",
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: null),
    );
  }
}

class NWebView extends StatefulWidget {
  const NWebView({super.key});

  @override
  State<NWebView> createState() => _NWebViewState();
}

class _NWebViewState extends State<NWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse("https://google.com"));
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
                IconButton(onPressed: (){
                  controller.reload();
                }, icon: Icon(Icons.replay))
            ],
          )
        ],
      ),
    ,
    );
  }
}
