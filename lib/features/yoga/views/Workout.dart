import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state_management/controllers/timer_controller.dart';
import '../../../state_management/controllers/yoga_controller.dart';
import '../../../utils/colours.dart';

class Workout extends StatelessWidget {
  static const id = "/workout";
  const Workout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WorkoutTimerController>(
      create: (context)=>WorkoutTimerController(context) ,
      child: Scaffold(
        body: Consumer<YogaController>(
          builder: (_, yogaController, __) =>
          Consumer<WorkoutTimerController>(
            builder: (_, workoutController, __) =>
            Stack(
              children: [
                Container(
                  child: Column(

                    children: [
                      Container(
                        height: 350,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=920&q=80")
                            )
                        ),
                      ),
                      const Spacer(),
                      Text(yogaController.current!.title! , style: const TextStyle(fontWeight: FontWeight.w600 , fontSize: 35),),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 80),
                        padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 25),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("00" , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30 ,color: Colors.white),),
                            const Text(" : " , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30 ,color: Colors.white),),
                            Consumer<WorkoutTimerController>(
                              builder: (context , myModel , child){
                                return  Text("${myModel.countdown < 10 ? "0${myModel.countdown}" : myModel.countdown}" ,style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 30 ,color: Colors.white),);
                              },

                            )],
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(height: 30,),
                      ElevatedButton(
                          onPressed: () {
                            workoutController.paused ? workoutController.resume(context) : workoutController.pause();
                            workoutController.show();
                      }, child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 15),
                          child: Text(workoutController.paused ? "RESUME" : "PAUSE" ,style: const TextStyle(fontSize: 20),))),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(onPressed: () {
                              yogaController.playPrev();
                              workoutController.reset();
                            }, child: const Text("Previous" , style: TextStyle(fontSize: 16),)),
                            TextButton(onPressed: () {
                              yogaController.playNext();
                              workoutController.reset();
                              }, child: const Text("Next" , style: TextStyle(fontSize: 16),))
                          ],
                        ),
                      ),          const Divider( thickness: 2,),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 15),
                            child: Text("Next: ${yogaController.next?.title}" , style: const TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),),
                          ))

                    ],
                  ),
                ),
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
                              OutlinedButton(onPressed: (){}, child: const SizedBox(
                                width: 180,
                                child: Text("Restart" , style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                              ) ),
                              OutlinedButton(onPressed: (){}, child: const SizedBox(
                                width: 180,
                                child: Text("Quit" , style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                              ) ),
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
            ),
          ),
        ),
      ),);
  }
}
