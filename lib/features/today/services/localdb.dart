import 'package:shared_preferences/shared_preferences.dart';

class LocalDB{
  static const String kTimeKey = "timeKey";
  static String kLastDoneOn = "lastDone";
  static String kStreakKey = "streakKey";
  static String kCalKey = "calKey";
  static String kWorkOutTimeKey = "workoutTimeKey";
  static String kFirstTime = "firstTimeKey";
  static String kDoneWorkout = "doneWorkout";

  //To calculate workout duration
  static Future<bool> setStartTime(String time) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(kTimeKey, time);
  }


  static Future<String?> getStartTime() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(kTimeKey);
  }



//To maintain the streak increment

  static Future<bool> setLastDoneOn(String date) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(kLastDoneOn, date);
  }


  static Future<String?> getLastDoneOn() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(kLastDoneOn);
  }



//To fetch and save the value of streak
  static Future<bool> setStreak(int streak) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setInt(kStreakKey, streak);
  }


  static Future<int?> getStreak() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(kStreakKey);
  }



// To fetch and save the kCAL of workout
  static Future<bool> setKCal(int kcal) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setInt(kCalKey, kcal);
  }


  static Future<int?> getKcal() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(kCalKey);
  }





//To save and fetch the overall workout time
  static Future<bool> setWorkOutTime(int minutes) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setInt(kWorkOutTimeKey, minutes);
  }


  static Future<int?> getWorkOutTime() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(kWorkOutTimeKey);
  }

  /// done workout
  static Future<void> saveDoneWorkout(List<String> doneWorkout) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(kDoneWorkout, doneWorkout);
  }

  static Future<List<String>?> getDoneWorkout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(kDoneWorkout);
  }




  static Future<bool> setFirstTime(bool isFirstTime) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(kFirstTime, isFirstTime);
  }


  static Future<bool?> getFirstTime() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(kFirstTime);
  }

}