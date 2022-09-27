import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../../state_management/controllers/timer_controller.dart';
import '../../../state_management/controllers/yoga_controller.dart';

class AreYouReadyScreen extends StatelessWidget {
  static const id = "/rUReady";
  const AreYouReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CountdownTimerController>(
      create: (context) => CountdownTimerController(context),
      child: Scaffold(
          body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 2 - 100),
            const Text(
              "GET READY!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 40),
            Consumer<CountdownTimerController>(
              builder: (_, timeController, __) {
                return Text(
                  timeController.countdown.toString(),
                  style: const TextStyle(fontSize: 48),
                );
              }
            ),
            const Spacer(),
          const Divider(thickness: 2),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(
                    "Next: ${Provider.of<YogaController>(context, listen: false).next!.title!}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18
                  ),
                ),
              ),
            ),
          ],
        ),
      ),),);
  }
}
