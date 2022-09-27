import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/session.dart';
import '../../../state_management/controllers/yoga_controller.dart';
import '../../today/services/localdb.dart';
import '../views/are_you_ready_screen.dart';
import '../widgets/session_widget.dart';


class Sessions extends StatelessWidget {
  const Sessions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<YogaController>(
      builder: (_, controller, __) {
          List<SessionWidget> sessions = List.generate(
            controller.sessions.length,
            (idx) {
              Session session = controller.sessions[idx];
              return SessionWidget(
                title: session.title!,
                active: session.active,
                onTap: () {
                  controller.play(session);
                  Navigator.pushNamed(context, AreYouReadyScreen.id);
                },
              );
            }
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i = 0; i < 6; i += 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      sessions[i],
                      const Spacer(),
                      sessions[i + 1],
                    ],
                  ),
            ],
          );
  }
    );
  }
}
