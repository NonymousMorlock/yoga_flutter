import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../features/today/services/localdb.dart';
import 'yoga_controller.dart';

class UpdateFitnessController with ChangeNotifier {
  UpdateFitnessController(BuildContext context) {
    difference = 0;
    burntCal = 0;
    SetWorkoutTime();
    lastWorkOutDoneOn();
    _yogaController = Provider.of<YogaController>(context, listen: false);
    if(_yogaController.workoutName != Workout.diet) {
      setMyKCal(13);
    }
  }
  int a = 1;
  late YogaController _yogaController;
  int difference = 0;
  int burntCal = 0;

  void SetWorkoutTime() async {
    String? startTime = await LocalDB.getStartTime();
    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss")
        .parse(startTime ?? "2022-05-24 19:31:15.182");
    difference = DateTime.now().difference(tempDate).inMinutes;
    int? mywotime = await LocalDB.getWorkOutTime();
    int newTime;
    if (mywotime != null) {
      newTime = mywotime + difference;
    } else {
      newTime = difference;
    }
    LocalDB.setWorkOutTime(newTime);
    _yogaController.setStats(workoutMinutes: newTime);
  }

  void lastWorkOutDoneOn() async {
    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss")
        .parse(await LocalDB.getLastDoneOn() ?? "2022-05-24 19:31:15.182");
    int difference = DateTime.now().difference(tempDate).inDays;
    if (!(difference == 0)) {
      int? streaknow = await LocalDB.getStreak();
      int newStreak;
      if (streaknow != null) {
        newStreak = streaknow + 1;
      } else {
        newStreak = 1;
      }
      LocalDB.setStreak(newStreak);
      _yogaController.setStats(streak: newStreak);
      _yogaController.resetDayWorkout();
    }

    await LocalDB.setLastDoneOn(DateTime.now().toString());
  }

  void setMyKCal(int myKCAL) async {
    burntCal = myKCAL;
    int? kcal = await LocalDB.getKcal();
    int newCal;
    if (kcal != null) {
      newCal = kcal + myKCAL;
    } else {
      newCal = 0;
    }
    LocalDB.setKCal(newCal);
    _yogaController.setStats(kCal: newCal);
  }
//TODO: Set the initial value of straek and lastdone on in starting of app
}