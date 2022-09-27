import 'package:flutter/material.dart';

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
              Icons.dehaze,
              color: drawerTween.value,
            ),
            onPressed: onPressed,
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
            Icon(Icons.notifications, color: iconTween.value),
            CircleAvatar(
              backgroundColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
