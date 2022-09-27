
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state_management/controllers/state_controller.dart';
import '../../../utils/dimensions.dart';

class SmallText extends StatelessWidget {
  const SmallText({
    Key? key,
    required this.text,
    this.size,
    this.height,
    this.colour,
}) : super(key: key);

  final String text;
  final double? height;
  final double? size;
  final Color? colour;

  Color themeColour(BuildContext context, {Color? darkColour, Color? lightColour}) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDark = brightness == Brightness.dark;
    Color scaffoldColour = Theme.of(context).scaffoldBackgroundColor;
    switch(Provider.of<StateController>(context, listen: false).themeMode) {
      case ThemeMode.dark:
        return darkColour ?? scaffoldColour;
      case ThemeMode.light:
        return lightColour ?? Colors.white;
      case ThemeMode.system:
        return isDark ? darkColour ?? scaffoldColour : lightColour ?? Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: colour ?? themeColour(context, lightColour: Colors.black, darkColour: Colors.white),
        height: height == null ? Dimensions.customTextHeight(1.2) : Dimensions.customTextHeight(height!),
        fontSize: size != null ? Dimensions.customSize(size!) : Dimensions.customSize(12),
      ),
    );
  }
}