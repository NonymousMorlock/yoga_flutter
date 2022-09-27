import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state_management/controllers/timer_controller.dart';
import '../../../state_management/controllers/yoga_controller.dart';

class WorkoutBody extends StatelessWidget {
  const WorkoutBody({super.key, required this.endPoint});
  final String endPoint;

  @override
  Widget build(BuildContext context) {
    return Consumer<YogaController>(
      builder: (_, yogaController, __) => Container(
        child: Column(
          children: [
            Container(
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("asset/$endPoint"),
              )),
            ),
            const Spacer(),
            Text(
              yogaController.current!.title!,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 80),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "00",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  const Text(
                    " : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  Consumer<WorkoutTimerController>(
                    builder: (context, myModel, child) {
                      return Text(
                        "${myModel.countdown < 10 ? "0${myModel.countdown}" : myModel.countdown}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      );
                    },
                  )
                ],
              ),
            ),
            const Spacer(),
            const SizedBox(
              height: 30,
            ),
            Consumer<WorkoutTimerController>(builder: (_, workoutController, __) {
              return ElevatedButton(
                  onPressed: () {
                    workoutController.paused
                        ? workoutController.resume(context)
                        : workoutController.pause();
                    workoutController.show();
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text(
                        workoutController.paused ? "RESUME" : "PAUSE",
                        style: const TextStyle(fontSize: 20),
                      )));
            }),
            const Spacer(),
            Consumer<WorkoutTimerController>(
              builder:(_, workoutController, __) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          yogaController.playPrev();
                          workoutController.reset();
                        },
                        child: const Text(
                          "Previous",
                          style: TextStyle(fontSize: 16),
                        )),
                    TextButton(
                        onPressed: () {
                          yogaController.playNext(context);
                          if (yogaController.next!.title!.toLowerCase() != "finish") {
                            workoutController.reset();
                          }
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    "Next: ${yogaController.next?.title}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
