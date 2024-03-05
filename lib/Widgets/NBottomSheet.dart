import 'package:flutter/material.dart';

class NBottomSheet extends StatefulWidget {
  final Widget child;
  const NBottomSheet({super.key, required this.child});

  @override
  State<NBottomSheet> createState() => _NBottomSheetState();
}

class _NBottomSheetState extends State<NBottomSheet> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onChanged);
  }

  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= 0.55) collapse();
  }

  void collapse() => animateSheet(getSheet.snapSizes!.first);
  void anchor() => animateSheet(getSheet.snapSizes!.last);
  void expand() => animateSheet(getSheet.maxChildSize);
  void hide() => animateSheet(getSheet.minChildSize);

  void animateSheet(double size) {
    controller.animateTo(size,
        duration: Duration(microseconds: 50), curve: Curves.easeInOut);
  }

  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints) {
      return DraggableScrollableSheet(
          key: sheet,
          initialChildSize: 0.5,
          maxChildSize: 1,
          minChildSize: 0,
          expand: true,
          snap: true,
          snapSizes: [60 / constraints.maxHeight, 0.5],
          builder: (BuildContext context, ScrollController scrollController) {
            return DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0, 1))
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22))),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  topButtonIndicator(),
                  SliverToBoxAdapter(
                    child: widget.child,
                  )
                ],
              ),
            );
          });
    });
  }

  SliverToBoxAdapter topButtonIndicator() {
    return SliverToBoxAdapter(
      child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            Container(
                child: Center(
                    child: Wrap(children: <Widget>[
              Container(
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  )),
            ]))),
          ])),
    );
  }
}

