import 'package:flutter/material.dart';

class SessionWidget extends StatelessWidget {
  const SessionWidget({
    super.key,
    required this.active,
    required this.title,
    required this.onTap,
  });

  final bool active;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                spreadRadius: 1)
          ]),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Icon(
              active ? Icons.play_circle_filled : Icons.play_circle_outline,
              color: const Color(0xff817dc0),
              size: 50,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
