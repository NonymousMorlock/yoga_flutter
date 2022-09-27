import 'dart:ui';

import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;


  static double customSize(double size) {
    double customSizeFactor = screenHeight / size;
    return screenHeight / customSizeFactor;
  }

  static double customTextHeight(double textHeight) {
    double customTextHeightFactor = screenHeight / textHeight;
    return screenHeight / customTextHeightFactor;
  }
}