import 'package:flutter/material.dart';

import '../../../../utils/colours.dart';
import '../../../home/widgets/category_tile.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.onTap});
  final void Function(String, String) onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(50, 120, 50, 50),
          decoration: BoxDecoration(
            color: Colours.purpleColour,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: const [
                  Text(
                      "1",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                  Text(
                      "Streak",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Text(
                    "120",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                  Text(
                    "kCal",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Text(
                    "26",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                  Text(
                    "Minutes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Text(
                "Your Day",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                children: <Widget>[
                  CategoryTile(
                    img: 'img1',
                    title: "Diet Recommendation",
                  ),
                  CategoryTile(
                    img: 'img2',
                    title: "Kegel Exercise",
                  ),
                  CategoryTile(
                    img: 'img3',
                    title: "Meditation",
                  ),
                  CategoryTile(
                    img: 'img4',
                    title: "Yoga",
                  ),

                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "You May Like",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                children: <Widget>[
                  CategoryTile(
                    img: 'img1',
                    title: "Diet Recommendation",
                    onTap: onTap,
                  ),
                  CategoryTile(
                    img: 'img2',
                    title: "Kegel Exercise",
                    onTap: onTap,
                  ),
                  CategoryTile(
                    img: 'img3',
                    title: "Meditation",
                    onTap: onTap,
                  ),
                  CategoryTile(
                    img: 'img4',
                    title: "Yoga",
                    onTap: onTap,
                  ),

                ],
              ),
            ],
          ),
        ),
      ],
    );
  }


}














