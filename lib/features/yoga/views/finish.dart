import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';

import '../../../state_management/controllers/state_controller.dart';
import '../../../state_management/controllers/update_fitness_controller.dart';
import '../../../state_management/controllers/yoga_controller.dart';
import '../../../utils/colours.dart';
import '../../settings/widgets/rating_dialog.dart';
import '../../today/services/localdb.dart';
import 'are_you_ready_screen.dart';

class Finish extends StatefulWidget {
  static const id = "/finish";
  const Finish({Key? key}) : super(key: key);

  @override
  State<Finish> createState() => _FinishState();
}

class _FinishState extends State<Finish> {


  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, Provider.of<YogaController>(context, listen: false).workoutMinutes! < 2 ? "Motion" : "State Machine 1");
    artboard.addController(controller!);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UpdateFitnessController>(
      create: (context) {
        return UpdateFitnessController(context);
        },
      child: Scaffold(
        body: Consumer<YogaController>(
          builder: (_, yogaController, __) => Stack(
            children: [
              Container(
                  height: double.maxFinite,
                  child: RiveAnimation.asset("asset/${yogaController.workoutMinutes! < 2 ? "waiting" : "bloom"}.riv", fit: BoxFit.cover, onInit: _onRiveInit)
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          yogaController.workoutMinutes! > 1
                              ? "asset/trophy.png"
                              : "asset/lazy.png",
                          width: 350,
                          height: 350,
                        )
                      ],
                    ),
                  ),
                  Consumer<UpdateFitnessController>(
                    builder: (_, fitController, ___) =>
                        Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 13, horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                fitController.burntCal.toString(),
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: yogaController.workoutMinutes! > 2 ? Colors.purple : Colors.white
                                ),
                              ),
                              Text(
                                "KCal",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: yogaController.workoutMinutes! > 2 ? Colors.purple : Colors.white),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                fitController.difference.toString(),
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: yogaController.workoutMinutes! > 2 ? Colors.purple : Colors.white),
                              ),
                              Text(
                                "Minutes",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: yogaController.workoutMinutes! > 2 ? Colors.purple : Colors.white),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                   Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              yogaController.play(yogaController.sessions[0]);
                              Navigator.popAndPushNamed(
                                  context, AreYouReadyScreen.id
                              );
                            },
                            child: Text(
                              "DO IT AGAIN",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: yogaController.workoutMinutes! > 2 ? Colors.purple : Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              SnackBar snackBar = SnackBar(
                                content: const Text("Link Copied to Clipboard"),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colours.peachColour,
                                margin: const EdgeInsets.all(20),
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              );
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar(
                                    reason: SnackBarClosedReason.remove)
                                ..showSnackBar(snackBar);
                            },
                            child: Text(
                              "SHARE",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: yogaController.workoutMinutes! > 2 ? Colors.purple : Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const Divider(
                    thickness: 2,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => const RatingDialog(),
                                  barrierDismissible: true,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                child: const Text(
                                  "RATE OUR APP",
                                  style: TextStyle(fontSize: 20,
                                    color: Colors.purple),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  // const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


