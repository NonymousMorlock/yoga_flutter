import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.animationController,
      required this.colorsTween,
      required this.homeTween,
      required this.yogaTween,
      required this.iconTween,
      required this.drawerTween,
      this.onPressed,
      });
  final AnimationController animationController;
  final Animation colorsTween, homeTween, yogaTween, iconTween, drawerTween;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (_, child) => AppBar(
          leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.dumbbell,
              color: drawerTween.value,
            ),
            onPressed: null,
          ),
          backgroundColor: colorsTween.value,
          elevation: 0,
          title: Row(
            children: [
              Text(
                  "TODAY",
                style: TextStyle(
                  color: homeTween.value,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              Text(
                  "YOGA",
                style: TextStyle(
                  color: yogaTween.value,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: onPressed,
                child: Icon(Icons.notifications, color: iconTween.value)),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.green,
                child: Image.asset("asset/pfp.png"),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
