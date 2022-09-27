import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state_management/controllers/timer_controller.dart';
import '../../../state_management/controllers/yoga_controller.dart';
import '../../../utils/dimensions.dart';
import '../widgets/expandable_text.dart';
import 'diet_recommendation.dart';

class DietBody extends StatelessWidget {
  const DietBody({super.key, required this.endPoint});

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
            Container(
              height: Dimensions.screenHeight * .41,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.customSize(20)),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Center(
                    child: Text(
                      DietRecommendations.titles[yogaController.current!.idx],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ExpandableText(text: DietRecommendations.bodies[yogaController.current!.idx])
                ],
              ),
            ),
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
