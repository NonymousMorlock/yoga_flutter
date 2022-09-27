import 'package:flutter/material.dart';

import '../../features/today/services/localdb.dart';
import '../../features/yoga/views/finish.dart';
import '../../models/session.dart';

enum Workout { yoga, kegel, meditation, diet }

class YogaController extends ChangeNotifier {
  final List<Session> _sessions = [];

  List<Session> get sessions => _sessions;
  Workout _workoutName = Workout.yoga;
  Workout get workoutName => _workoutName;
  List<Workout> _doneWorkout = [];
  List<Workout> get doneWorkout => _doneWorkout;

  int? _streak, _kCal, _workoutMinutes;
  int? get streak => _streak;
  int? get kCal => _kCal;
  int? get workoutMinutes => _workoutMinutes;

  void setStats({int? streak, int? kCal, int? workoutMinutes}) {
    _streak = streak ?? _streak;
    _kCal = kCal ?? _kCal;
    _workoutMinutes = workoutMinutes ?? _workoutMinutes;
    notifyListeners();
  }

  Session? next;
  Session? current;

  static final Session finish = Session(idx: 10, title: "Finish");

  void addWorkout() {
    if(!_doneWorkout.contains(_workoutName)) {
      _doneWorkout.add(_workoutName);
      saveDoneWorkout();
      notifyListeners();
    }
  }

  void resetDayWorkout() {
    _doneWorkout = [];
    addWorkout();
    notifyListeners();
  }

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

  void saveDoneWorkout() async {
    List<String> doneWorkout = [];
    for(final workout in _doneWorkout) {
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
    await LocalDB.saveDoneWorkout(doneWorkout);
  }

  void getDoneWorkout() async {
    List<String>? doneWorkout = await LocalDB.getDoneWorkout();
    if(doneWorkout != null) {
      List<Workout> retrieved = [];
      for(final workout in doneWorkout) {
        retrieved.add(converter(workout));
      }
      _doneWorkout = retrieved;
    }
  }

  void setWorkoutName(String workout) {
    _workoutName = converter(workout);
  }

  void addSession(Session session) {
    _sessions.add(session);
  }

  void play(Session session, [bool invoke = true]) {
    for (Session currentSession in _sessions) {
      currentSession.active = false;
    }
    for (int i = 0; i < _sessions.length; i++) {
      final currentSession = _sessions[i];
      if (currentSession.title == session.title) {
        currentSession.active = true;
        if (invoke) {
          next = i < _sessions.length - 1 ? _sessions[i + 1] : finish;
          current = currentSession;
        }
      }
    }
    notifyListeners();
  }

  void playNext([BuildContext? context]) {
    if(current!.idx == 2) {
      addWorkout();
    }
    if (next!.title!.toLowerCase() != "finish") {
      current = next;
      next = next!.idx < 5 ? _sessions[next!.idx + 1] : finish;
      play(current!, false);
      notifyListeners();
    } else {
      if(_workoutName == Workout.diet) {
        Navigator.popAndPushNamed(context!, Finish.id);
      }
    }
  }

  void playPrev() {
    if (current!.title!.toLowerCase() != "finish") {
      next = current;
      current = _sessions[current!.idx > 0 ? current!.idx - 1 : 0];
      play(current!, false);
      notifyListeners();
    }
  }
}
