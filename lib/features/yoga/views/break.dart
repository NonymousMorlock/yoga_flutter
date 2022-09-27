import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state_management/controllers/timer_controller.dart';
import '../../../state_management/controllers/yoga_controller.dart';
import 'workout.dart';

class BreakTime extends StatelessWidget {
  static const id = "/break";
  const BreakTime({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BreakTimerController>
      (create:(context)=>BreakTimerController(context) ,
      child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("asset/break.jpg")
                )
            ),
            child: Consumer<YogaController>(
              builder: (_, yogaController, __) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text("Break Time" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),),
                  Consumer<BreakTimerController>(
                    builder: (context , myModel , child){
                      return  Text(myModel.countdown.toString() ,style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 55 ,color: Colors.black),);
                    },

                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    yogaController.playNext();
                    Navigator.popAndPushNamed(context, WorkoutScreen.id);
                  }, child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 24),

                    child: Text("SKIP" ,style: TextStyle(fontSize: 19),),
                  )),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){
                          yogaController.playPrev();
                          Navigator.popAndPushNamed(context, WorkoutScreen.id);
                        }, child: const Text("Previous" , style: TextStyle(fontSize: 16),)),
                        TextButton(
                          onPressed: (){
                          yogaController.playNext();
                          Navigator.popAndPushNamed(context, WorkoutScreen.id);
                        }, child: const Text("Next" , style: TextStyle(fontSize: 16),),),
                      ],
                    ),
                  ),          const Divider(thickness: 2),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 15),
                        child: Text("Next: ${yogaController.next!.title}" , style: const TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),),
                      ),),
                ],
              ),
            ),
          )


      ),);
  }
}
