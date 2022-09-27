import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state_management/controllers/timer_controller.dart';
import '../../../state_management/controllers/yoga_controller.dart';
import '../../../utils/colours.dart';
import '../components/diet_body.dart';
import '../components/workout_body.dart';
import 'are_you_ready_screen.dart';

class WorkoutScreen extends StatelessWidget {
  static const id = "/workout";
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WorkoutTimerController>(
      create: (context)=>WorkoutTimerController(context) ,
      child: Scaffold(
        body: Consumer<YogaController>(
          builder: (_, yogaController, __) =>
          Consumer<WorkoutTimerController>(
            builder: (_, workoutController, __) {
              String endPoint;
              int idx = yogaController.current!.idx + 1;
              switch(yogaController.workoutName) {

                case Workout.yoga:
                  endPoint = "yoga/$idx.png";
                  break;
                case Workout.kegel:
                  endPoint = "kegels/$idx.png";
                  break;
                case Workout.meditation:
                  endPoint = "meditation/meditate.gif";
                  break;
                case Workout.diet:
                  endPoint = "food_recommendation/$idx.jpg";
                  break;
              }
            return Stack(
              children: [
                yogaController.workoutName != Workout.diet ? WorkoutBody(
                  endPoint: endPoint,
                ) : DietBody(endPoint: endPoint,),
                Consumer<WorkoutTimerController>(
                  builder: (context , myModel , child){
                    return  Visibility(
                        visible: myModel.visible,
                        child: Container(
                          color: Colours.peachColour.withOpacity(0.9),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Pause" , style: TextStyle(fontSize: 40,color: Colors.white , fontWeight: FontWeight.bold),),
                              const SizedBox(height: 10,),
                              const Text("Yoga feels better" , style: TextStyle(fontSize: 13 , color: Colors.white),),
                              const SizedBox(height: 30,),
                              OutlinedButton(onPressed: (){
                                yogaController.play(yogaController.sessions[0]);
                                Navigator.popAndPushNamed(
                                    context, AreYouReadyScreen.id
                                );
                              }, child: const SizedBox(
                                width: 180,
                                child: Text("Restart" , style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                              ) ),
                              OutlinedButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: const SizedBox(
                                width: 180,
                                child: Text("Quit" , style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                              ) ),
                              /// Resume
                              OutlinedButton(onPressed: (){
                                myModel.hide();
                                workoutController.resume(context);
                              }, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)), child: const SizedBox(
                                width: 180,
                                child: Text("RESUME" , textAlign: TextAlign.center,),
                              ), )
                            ],
                          ),
                        ));
                  },

                )
              ],
            );}
          ),
        ),
      ),);
  }
}

