

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga_flutter/state_management/controllers/yoga_controller.dart';

class MockYogaController {
  List<Workout> workouts = [
    Workout.diet,
    Workout.kegel,
  ];

  Workout converter(String workout) {
    switch (workout.toLowerCase()) {
      case "yoga":
        return Workout.yoga;
      case "meditation":
        return Workout.meditation;
      case "kegel exercise":
        return Workout.kegel;
      case "diet recommendation":
        return Workout.diet;
      default:
        throw "That workout doesn't exist";
    }
  }

  void saveDoneWorkout(SharedPreferences prefs) {
    List<String> doneWorkout = [];
    for(final workout in workouts) {
      switch (workout) {
        case Workout.yoga:
          doneWorkout.add("yoga");
          break;
        case Workout.meditation:
          doneWorkout.add("meditation");
          break;
        case Workout.kegel:
          doneWorkout.add("kegel exercise");
          break;
        case Workout.diet:
          doneWorkout.add("diet recommendation");
          break;
      }
    }
    prefs.setStringList("key", doneWorkout);
  }

  void getDoneWorkout(SharedPreferences prefs) {
      List<String>? doneWorkout = prefs.getStringList("key");
      if(doneWorkout != null) {
        List<Workout> retrieved = [];
        for(final workout in doneWorkout) {
          retrieved.add(converter(workout));
        }
        workouts = retrieved;
      }
  }
}

void main() {
  test("done workout test", () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MockYogaController mockYogaController = MockYogaController();
    List<Workout> workouts = mockYogaController.workouts;

    mockYogaController.saveDoneWorkout(prefs);
    mockYogaController.getDoneWorkout(prefs);

    expect(mockYogaController.workouts, workouts);
  });
}