import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../state_management/controllers/state_controller.dart';
import '../../../../state_management/controllers/yoga_controller.dart';
import '../../../../utils/colours.dart';
import '../../../home/widgets/category_tile.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.onTap,
    required this.streak,
    required this.kCal,
    required this.workoutMinutes,
  });
  final void Function(String, String) onTap;
  final String streak;
  final String kCal;
  final String workoutMinutes;

  List<CategoryTile> categories(YogaController yogaController) {
    return [
      CategoryTile(
        img: 'img1',
        title: "Diet Recommendation",
        visible: yogaController.doneWorkout.contains(Workout.diet),
      ),
      CategoryTile(
        img: 'img2',
        title: "Kegel Exercise",
        visible: yogaController.doneWorkout.contains(Workout.kegel),
      ),
      CategoryTile(
        img: 'img3',
        title: "Meditation",
        visible: yogaController.doneWorkout.contains(Workout.meditation),
      ),
      CategoryTile(
        img: 'img4',
        title: "Yoga",
        visible: yogaController.doneWorkout.contains(Workout.yoga),
      ),
    ];
  }
  List<CategoryTile> mayLike(YogaController yogaController) {
    return [
      CategoryTile(
        img: 'img1',
        title: "Diet Recommendation",
        visible: !yogaController.doneWorkout.contains(Workout.diet),
        onTap: onTap,
      ),
      CategoryTile(
        img: 'img2',
        title: "Kegel Exercise",
        visible: !yogaController.doneWorkout.contains(Workout.kegel),
        onTap: onTap,
      ),
      CategoryTile(
        img: 'img3',
        title: "Meditation",
        visible: !yogaController.doneWorkout.contains(Workout.meditation),
        onTap: onTap,
      ),
      CategoryTile(
        img: 'img4',
        title: "Yoga",
        visible: !yogaController.doneWorkout.contains(Workout.yoga),
        onTap: onTap,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<YogaController>(
      builder: (_, yogaController, __) => Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(50, 120, 50, 50),
            decoration: const BoxDecoration(
                color: Colours.purpleColour,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      streak,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                    const Text(
                      "Streak",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      kCal,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                    const Text(
                      "kCal",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      workoutMinutes,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                    const Text(
                      "Minutes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                const Text(
                  "Your Day",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (yogaController.doneWorkout.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Completed Sessions",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 0.85,
                        children: categories(yogaController).where((item) {
                          return item.visible;
                        }).toList(),
                      ),
                    ],
                  ),
                Visibility(
                  visible: yogaController.doneWorkout.isEmpty,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "You have not completed any sessions Today",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(Provider.of<StateController>(
                                    context,
                                    listen: false)
                                .imgBytes!),
                            colorFilter: ColorFilter.mode(
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.2),
                              BlendMode.dstATop,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "You May Like",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  children: mayLike(yogaController).where((element) => element.visible).toList(),
                ),
                Visibility(
                  visible: yogaController.doneWorkout.length == 4,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "You have attempted every session Today",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage(
                            "asset/split.png"),
                            colorFilter: ColorFilter.mode(
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.2),
                              BlendMode.dstATop,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
