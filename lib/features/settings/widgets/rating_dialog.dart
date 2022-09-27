import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../../state_management/controllers/rive_controller.dart';
import '../../../state_management/controllers/state_controller.dart';
import '../../../utils/colours.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late RiveAnimationController _controller;
  late StateMachineController? _machineController;
  static const List<String> states = [
    "idle_empty",
    "1_star",
    "2_stars",
    "3_stars",
    "4_stars",
    "5_stars"
  ];
  List<SMIInput<dynamic>?> inputs = [];
  static const List<Artboard> artBoards = [];
  static const String assetPath = "asset/tomat_o_meter.riv";

  Future<void> initializeArtBoard() async {
    final data = await rootBundle.load(assetPath);
    final file = RiveFile.import(data);
    final artBoard = file.mainArtboard;
    SMIInput<int>? input;
    final controller =
        StateMachineController.fromArtboard(artBoard, "State Machine 1");
    if (controller != null) {
      artBoard.addController(controller);
      input = controller.findInput<int>("0");
      input!.value = 0;
    }
    inputs.add(input);
    artBoards.add(artBoard);
  }

  void _togglePlay() =>
      setState(() => _controller.isActive = !_controller.isActive);

  bool get isPlaying => _controller.isActive;

  SMITrigger? _bump;

  void _onRiveInit(Artboard artboard) {
    _machineController =
        StateMachineController.fromArtboard(artboard, 'State Machine 1', onStateChange: (machine, animation) {
          Provider.of<RiveController>(context, listen: false).changeAnimation(animation);
        });
    artboard.addController(_machineController!);
    inputs = _machineController?.inputs as List<SMIInput<dynamic>>;
  }

  void _hitBump() => _bump?.fire();

  // @override
  // void didChangeDependencies() async{
  //   super.didChangeDependencies();
  //   await initializeArtBoard();
  //   setState(() {});
  // }

  void slideIn() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800))
      ..forward();
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _animationController.dispose();
    _machineController?.dispose();
  }

  @override
  void initState() {
    _controller = SimpleAnimation(Provider.of<RiveController>(context, listen: false).currentAnimation, autoplay: true);
    debugPrint(Provider.of<RiveController>(context, listen: false).currentAnimation);
    slideIn();
    super.initState();
  }

  Color colour(bool isDark) {
    switch(Provider.of<StateController>(context, listen: false).themeMode) {
      case ThemeMode.dark:
        return Colors.blueGrey;
      case ThemeMode.light:
        return Colors.white;
      case ThemeMode.system:
        return isDark ? Colors.blueGrey : Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool isDark = brightness == Brightness.dark;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: _animation,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: colour(isDark),
            height: h * .5,
            width: w * .8,
            child: Column(
              children: [
                Expanded(
                  child: Image.asset("asset/bannerChar.png"),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "How do you find your experience?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: RiveAnimation.asset(
                      assetPath,
                      fit: BoxFit.cover,
                      stateMachines: const ["State Machine 1"],
                      controllers: [_controller],
                      onInit: _onRiveInit,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.maxFinite, 50),
                        primary: Colours.purpleColour),
                    onPressed: () {
                      Provider.of<RiveController>(context, listen: false).lockInAnimation();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Rate",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colours.purpleColour, fontSize: 22),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
