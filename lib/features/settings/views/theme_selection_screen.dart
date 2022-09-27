import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

import '../../../state_management/controllers/state_controller.dart';
import '../../../utils/colours.dart';


class ThemeSelectionScreen extends StatelessWidget {
  static const id = "/theme_select";
  const ThemeSelectionScreen({Key? key}) : super(key: key);

  void _onClickHandler(StateController controller, idx) {
    switch(idx) {
      case 0:
        controller.changeTheme(ThemeMode.dark);
        break;
      case 1:
        controller.changeTheme(ThemeMode.light);
        break;
      case 2:
        controller.changeTheme(ThemeMode.system);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDark = brightness == Brightness.dark;
    return Consumer<StateController>(
      builder: (_, stateController, __) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: const Text("Theme"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xffc7b8f5),
          actions: [
            Hero(
              tag: "theme",
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  stateController.themeMode == ThemeMode.light
                      ? Icons.brightness_4_rounded
                      : stateController.themeMode == ThemeMode.dark
                          ? Icons.brightness_4_outlined
                          : Icons.brightness_5,
                  color: stateController.themeMode == ThemeMode.light
                      ? Colors.yellowAccent
                      : stateController.themeMode == ThemeMode.dark || isDark
                          ? Colors.purple
                          : Colours.peachColour,
                ),
              ),
            )
          ],
        ),
        body: ListView.separated(
          itemBuilder: (_, idx) {
            int activeIdx;
            switch(stateController.themeMode) {
              case ThemeMode.dark:
                activeIdx = 0;
                break;
              case ThemeMode.light:
                activeIdx = 1;
                break;
              case ThemeMode.system:
                activeIdx = 2;
                break;
            }
            return ListTile(
              title: Text(idx == 0 ? "On" : idx == 1 ? "Off" : "System"),
              subtitle: idx == 2 ? const Text("The appearance of this app will change based on your device's system settings") : null,
              trailing: activeIdx == idx ? Badge(
                badgeContent: const FaIcon(FontAwesomeIcons.check, size: 10),
                badgeColor: const Color(0xffc7b8f5),
              ) : null,
              onTap: () {
                _onClickHandler(stateController, idx);
              },
            );
          },
          separatorBuilder: (_, idx) {
            return Divider(
              color: isDark ? Colors.grey : null,
            );
          },
          itemCount: 3,
        ),
      ),
    );
  }
}
