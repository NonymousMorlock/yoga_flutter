

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class RiveController extends ChangeNotifier {
  String _currentAnimation = "idle_empty";
  String get currentAnimation => _currentAnimation;
  String _chosenAnimation = "idle_empty";
  SharedPreferences? prefs;

  void changeAnimation(String animation){
    _chosenAnimation = animation;
  }

  void lockInAnimation() async {
    debugPrint("here");
    _currentAnimation = _chosenAnimation;
    await saveAnimation();
  }

  void initPrefs(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  Future<void> saveAnimation() async {
    await prefs!.setString(kAnimationKey, _currentAnimation);
  }

  void getAnimation() {
    debugPrint("getting rating");
    final animation = prefs!.getString(kAnimationKey);
    if(animation != null) _currentAnimation = animation;
  }
}