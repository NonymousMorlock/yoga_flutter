import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/today/services/localdb.dart';
import '../../features/yoga/views/workout.dart';
import '../../features/yoga/views/break.dart';
import '../../features/yoga/views/finish.dart';
import 'yoga_controller.dart';


class CountdownTimerController extends ChangeNotifier {
  int countdown = 5;
  Timer? timerObject;
  late YogaController _yogaController;

  Future<void> timer(context) async{
    timerObject = Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      notifyListeners();
      if(countdown == 0){
        readTime();
        timer.cancel();
        Navigator.popAndPushNamed(context, WorkoutScreen.id);
        countdown = 5;
      }
    });
  }

  void readTime(){
    if(_yogaController.current?.idx == 0){
      String now = DateTime.now().toString();
      LocalDB.setStartTime(now);

    }

  }

  CountdownTimerController(BuildContext context) {
    timer(context);
    _yogaController = Provider.of<YogaController>(context, listen: false);
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
  late YogaController _yogaController;

  bool visible = false;
  bool paused = false;
  Future<void> timer(context) async{
    timerObject = Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      notifyListeners();
      if(countdown == 0){
        timer.cancel();
        if(_yogaController.next!.title!.toLowerCase() == "finish") {
          Navigator.popAndPushNamed(context, Finish.id);
        } else {
          Navigator.popAndPushNamed(context, BreakTime.id);
        }
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
    _yogaController = Provider.of<YogaController>(context, listen: false);
    if(_yogaController.workoutName != Workout.diet) {
      timer(context);
    }
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
        Navigator.popAndPushNamed(context, WorkoutScreen.id);
      }
    });
  }



  @override
  void dispose() {
    super.dispose();
    timerObject?.cancel();
  }
}

