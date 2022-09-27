import 'package:flutter/material.dart';

import '../../models/session.dart';


class YogaController extends ChangeNotifier {
  final List<Session> _sessions = [];

  List<Session> get sessions => _sessions;

  Session? next;
  Session? current;

  void addSession(Session session) {
    _sessions.add(session);
  }

  void play(Session session, [bool invoke = true]) {
    for(Session currentSession in _sessions) {
      currentSession.active = false;
    }
    for(int i = 0; i < _sessions.length; i++) {
      final currentSession = _sessions[i];
      if(currentSession.title == session.title) {
        currentSession.active = true;
        if(invoke) {
          next = i < _sessions.length - 1 ? _sessions[i + 1] : _sessions[0];
          current = currentSession;
        }
      }
    }
    notifyListeners();
  }

  void playNext() {
    current = next;
    next = _sessions[next!.idx < 5 ? next!.idx + 1 : 0];
    play(current!, false);
    notifyListeners();
  }
  void playPrev() {
    next = current;
    current = _sessions[current!.idx > 0 ? current!.idx - 1 : 5];
    play(current!, false);
    notifyListeners();
  }
}