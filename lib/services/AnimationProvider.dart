import 'package:flutter/foundation.dart';

class AnimationProvider extends ChangeNotifier {

  bool animatedListView = false;

  void setAnimatedListView (){
    if (animatedListView == false) {
      animatedListView = true;
    }

    notifyListeners();
  }
  
}