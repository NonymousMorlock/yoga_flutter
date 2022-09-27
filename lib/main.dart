import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga_flutter/features/home/views/dashboard.dart';
import 'package:yoga_flutter/features/home/views/splash_screen.dart';
import 'package:yoga_flutter/features/settings/views/theme_selection_screen.dart';
import 'package:yoga_flutter/features/today/view/notifications_screen.dart';
import 'package:yoga_flutter/features/yoga/views/workout.dart';
import 'package:yoga_flutter/features/yoga/views/are_you_ready_screen.dart';
import 'package:yoga_flutter/features/yoga/views/finish.dart';
import 'package:yoga_flutter/state_management/controllers/rive_controller.dart';
import 'package:yoga_flutter/state_management/controllers/state_controller.dart';
import 'package:yoga_flutter/state_management/controllers/timer_controller.dart';
import 'package:yoga_flutter/state_management/controllers/yoga_controller.dart';
import 'features/yoga/views/break.dart';
import 'features/yoga/views/product_page.dart';
import 'models/session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => StateController()),
      ChangeNotifierProvider(create: (_) => RiveController()),
      ChangeNotifierProvider(create: (_) => YogaController()),
    ], child: MyApp(prefs: prefs)),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.prefs});
  final SharedPreferences prefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    StateController stateController = Provider.of<StateController>(context, listen: false);
    if (stateController.prefs == null) {
      Provider.of<StateController>(context, listen: false)
          .initPrefs(widget.prefs);
    }
    if (Provider.of<RiveController>(context, listen: false).prefs == null) {
      Provider.of<RiveController>(context, listen: false)
          .initPrefs(widget.prefs);
    }
    Provider.of<StateController>(context, listen: false).getTheme();
    Provider.of<RiveController>(context, listen: false).getAnimation();
    YogaController yogaController =
        Provider.of<YogaController>(context, listen: false);
    yogaController.getDoneWorkout();
    for (int i = 0; i < 6; i++) {
      yogaController.addSession(Session(title: "Session ${i + 1}", idx: i));
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await stateController.getImgBytes();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<StateController>(context).themeMode,
      theme: ThemeData(
        fontFamily: 'Avenir',
        scaffoldBackgroundColor: const Color(0xfff8f8f8),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
          fontFamily: 'Avenir',
          scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
          textTheme: ThemeData.dark().textTheme,
          dividerTheme: ThemeData.dark().dividerTheme,
          bottomAppBarTheme: ThemeData.dark().bottomAppBarTheme,
          bottomNavigationBarTheme: ThemeData.dark().bottomNavigationBarTheme,
          appBarTheme: ThemeData.dark().appBarTheme),
      home: const SplashScreen(),
      routes: {
        ProductPage.id: (_) => const ProductPage(),
        DashBoard.id: (_) => const DashBoard(),
        ThemeSelectionScreen.id: (_) => const ThemeSelectionScreen(),
        AreYouReadyScreen.id: (_) => const AreYouReadyScreen(),
        NotificationScreen.id: (_) => const NotificationScreen(),
        WorkoutScreen.id: (_) => const WorkoutScreen(),
        BreakTime.id: (_) => const BreakTime(),
        Finish.id: (_) => const Finish(),
      },
    );
  }
}
