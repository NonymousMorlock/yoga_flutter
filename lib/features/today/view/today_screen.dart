import 'package:flutter/material.dart';

import '../../../utils/colours.dart';
import '../../yoga/views/product_page.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween, _homeTween, _yogaTween, _iconTween, _drawerTween;
  late AnimationController _textAnimationController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  void init() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));

    _colorTween = ColorTween(
            begin: Colors.transparent,
            end: Theme.of(context).scaffoldBackgroundColor)
        .animate(_animationController);

    _iconTween = ColorTween(begin: Colors.white, end: Colours.purpleColour)
        .animate(_animationController);

    _drawerTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);

    _homeTween = ColorTween(begin: Colors.white, end: Colours.peachColour)
        .animate(_animationController);

    _yogaTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);

    _textAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _textAnimationController.dispose();
  }

  bool scrollListener(ScrollNotification notification) {
    bool scroll = false;
    if (notification.metrics.axis == Axis.vertical) {
      _animationController.animateTo(notification.metrics.pixels / 80);
      _textAnimationController.animateTo(notification.metrics.pixels);
      scroll = true;
    }
    return scroll;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<ScrollNotification>(
        onNotification: scrollListener,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SafeArea(
                      child: Stack(
                        children: [
                          Body(onTap: openProductPage),
                        ],
                      ),
                    ),
                  ),
                  CustomAppBar(
                      animationController: _animationController,
                      colorsTween: _colorTween,
                      homeTween: _homeTween,
                      yogaTween: _yogaTween,
                      iconTween: _iconTween,
                      drawerTween: _drawerTween,
                    onPressed: _scaffoldKey.currentState?.openDrawer,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
      ),
    );
  }
  void openProductPage(String img, String title) =>
      Navigator.pushNamed(context, ProductPage.id,
          arguments: {'image': img, 'title': title});

}
