import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_applicaion/provider/language_provider.dart';
import 'package:meal_applicaion/provider/theme_provider.dart';
import 'package:meal_applicaion/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ThemesScreen extends StatelessWidget {
  bool fromOnBoarding;
  ThemesScreen({Key key, this.fromOnBoarding=false}) : super(key: key);

  Widget buildRadioListTile(ThemeMode themeMode,String txt, IconData icon, context) {
    return RadioListTile(
      // ignore: deprecated_member_use
      secondary: Icon(
        icon,
        color: Theme.of(context).buttonColor,
      ),
      value: themeMode,
      groupValue: Provider.of<ThemeProvider>(context, listen: true).tm,
      onChanged: (newThemeMode) =>
          Provider.of<ThemeProvider>(context, listen: false)
              .themeModeChange(newThemeMode),
      title: Text(txt),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    ListTile buildListTile(context, txt) {
      var primaryColor =
          Provider.of<ThemeProvider>(context, listen: true).primaryColor;
      var accentColor =
          Provider.of<ThemeProvider>(context, listen: true).accentColor;
      return ListTile(
        title: Text(lan.getTexts(txt),
            style: Theme.of(context).textTheme.headline6),
        trailing: CircleAvatar(
          backgroundColor: txt == "primary" ? primaryColor : accentColor,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                elevation: 4,
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: txt == "primary"
                        ? Provider.of<ThemeProvider>(context, listen: true)
                        .primaryColor
                        : Provider.of<ThemeProvider>(context, listen: true)
                        .accentColor,
                    onColorChanged: (color) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .onChange(color, txt == "primary" ? 1 : 2),
                    colorPickerWidth: 300.0,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: false,
                    displayThumbColor: true,
                    // ignore: deprecated_member_use
                    showLabel: false,
                  ),
                ),
              );
            },
          );
        },
      );
    }

    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: fromOnBoarding?null:Text(lan.getTexts("theme_appBar_title"),),
              elevation: fromOnBoarding?0.0:5.0,
              pinned: false,
              backgroundColor: fromOnBoarding? Theme.of(context).canvasColor: Theme.of(context).primaryColor,
            ),
            SliverList(delegate: SliverChildListDelegate([
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(20),
                child: Text(lan.getTexts("theme_screen_title"),
                    style: Theme.of(context).textTheme.headline6),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(lan.getTexts("theme_mode_title"),
                    style: Theme.of(context).textTheme.headline6),
              ),
              buildRadioListTile(
                  ThemeMode.system, lan.getTexts("System_default_theme"), null, context),
              buildRadioListTile(ThemeMode.light, lan.getTexts("light_theme"),
                  Icons.wb_sunny_outlined, context),
              buildRadioListTile(ThemeMode.dark, lan.getTexts("dark_theme"),
                  Icons.dark_mode_outlined, context),
              buildListTile(context, "primary"),
              buildListTile(context, "accent"),

              SizedBox(height:fromOnBoarding?100:0.0 ,)
            ]))
          ],
        ),
        drawer:fromOnBoarding?null:const MainDrawer(),
      ),
    );
  }
}

