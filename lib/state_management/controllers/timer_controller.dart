import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/yoga/views/Workout.dart';
import '../../features/yoga/views/break.dart';
import 'yoga_controller.dart';


class CountdownTimerController extends ChangeNotifier {
  int countdown = 5;
  Timer? timerObject;

  Future<void> timer(context) async{
    timerObject = Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      notifyListeners();
      if(countdown == 0){
        timer.cancel();
        Navigator.popAndPushNamed(context, Workout.id);
        countdown = 5;
      }
    });
  }

  CountdownTimerController(BuildContext context) {
    timer(context);
  }

  @override
  void dispose() {
    super.dispose();
    timerObject?.cancel();
  }
}

class WorkoutTimerController extends ChangeNotifier {
  int countdown = 30;
  Timer? timerObject;

  bool visible = false;
  bool paused = false;
  Future<void> timer(context) async{
    timerObject = Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      notifyListeners();
      if(countdown == 0){
        timer.cancel();
        Navigator.popAndPushNamed(context, BreakTime.id);
        countdown = 30;
      }
    });
  }

  void pause() {
    timerObject?.cancel();
    paused = true;
    notifyListeners();
  }
  void resume(context) {
    paused = false;
    timer(context);
  }
  void reset() {
    countdown = 30;
    notifyListeners();
  }

  void show(){
    visible = true;
    notifyListeners();
  }

  void hide(){
    visible  =  false;
    notifyListeners();
  }

  WorkoutTimerController(BuildContext context) {
    timer(context);
  }

  @override
  void dispose() {
    super.dispose();
    timerObject?.cancel();
  }

}

class BreakTimerController with ChangeNotifier{
  BreakTimerController(context){
    timer(context);
    _yogaController = Provider.of<YogaController>(context, listen: false);
  }
  int countdown = 20;
  late YogaController _yogaController;
  Timer? timerObject;

  void timer(context) async{
    timerObject = Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      notifyListeners();
      if(countdown == 0){
        timer.cancel();
        _yogaController.playNext();
        Navigator.popAndPushNamed(context, Workout.id);
      }
    });
  }



  @override
  void dispose() {
    super.dispose();
    timerObject?.cancel();
  }
}

