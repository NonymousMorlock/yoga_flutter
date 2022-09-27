import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state_management/controllers/state_controller.dart';
import '../../../utils/colours.dart';
import '../../../utils/constants.dart';
import '../widgets/rating_dialog.dart';
import 'theme_selection_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _clickHandler(BuildContext context, int idx) {
    switch (idx) {
      case 0:
        Navigator.pushNamed(context, ThemeSelectionScreen.id);
        break;
      case 1:
        showDialog(
          context: context,
          builder: (_) => const RatingDialog(),
          barrierDismissible: true,
        );
        break;
      case 2:
        showAboutDialog(
            context: context,
            applicationLegalese: kApplicationLegalese,
            applicationIcon: Center(
                child:
                    SizedBox(height: 40, child: Image.asset(kApplicationIcon))),
            applicationName: kApplicationName,
            applicationVersion: kApplicationVersion);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDark = brightness == Brightness.dark;
    return Consumer<StateController>(
      builder: (_, sCont, __) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colours.peachColour,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              sCont.changeIndex(sCont.previousIndex);
            },
          ),
          title: const Text("Settings"),
          centerTitle: true,
        ),
        body: ListView.separated(
          itemBuilder: (_, index) {
            return index == 2
                ? AboutListTile(
                    applicationLegalese: kApplicationLegalese,
                    applicationIcon: Center(
                        child: SizedBox(
                            height: 40, child: Image.asset(kApplicationIcon))),
                    applicationName: kApplicationName,
                    applicationVersion: kApplicationVersion,
                  )
                : ListTile(
                    leading: Text(index == 0 ? "Dark Mode" : "Rate Us"),
                    trailing: index == 0
                        ? Hero(
                            tag: "theme",
                            child: Icon(
                              sCont.themeMode == ThemeMode.light
                                  ? Icons.brightness_4_rounded
                                  : sCont.themeMode == ThemeMode.dark
                                      ? Icons.brightness_4_outlined
                                      : Icons.brightness_5,
                              color: sCont.themeMode == ThemeMode.light
                                  ? Colors.yellowAccent
                                  : sCont.themeMode == ThemeMode.dark || isDark
                                      ? Colors.purple
                                      : Colours.peachColour,
                            ),
                          )
                        : const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                    onTap: () {
                      _clickHandler(context, index);
                    },
                  );
          },
          separatorBuilder: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              color: isDark ? Colors.grey : null,
            ),
          ),
          itemCount: 3,
        ),
      ),
    );
  }
}
