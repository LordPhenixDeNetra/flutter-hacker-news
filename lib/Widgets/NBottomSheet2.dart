import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NBottomSheet2 extends StatelessWidget {
  final Widget child;

  const NBottomSheet2({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints) {
      return DraggableScrollableSheet(
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
                  offset: Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                topButtonIndicator(),
                SliverToBoxAdapter(
                  child: child,
                )
              ],
            ),
          );
        },
      );
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
                child: Wrap(
                  children: <Widget>[
                    Container(
                      width: 100,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
