// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:meal_applicaion/provider/language_provider.dart';
import 'package:meal_applicaion/provider/theme_provider.dart';
import 'package:meal_applicaion/screens/themes_screen.dart';
import 'package:meal_applicaion/screens/filter_screen.dart';
import 'package:meal_applicaion/screens/layout_screen.dart';
import 'package:meal_applicaion/widgets/category_item.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  Widget buildListTile(
      IconData icon, String title, Function function, context) {
    return ListTile(
      leading: Icon(
        icon,
        // ignore: deprecated_member_use
        color: Theme.of(context).buttonColor,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 24,
            fontFamily: "RobotoCondensed",
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyText1.color),
      ),
      onTap: function,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                // ignore: deprecated_member_use
                color: Theme.of(context).accentColor,
                width: double.infinity,
                height: 120,
                alignment: lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
                child: Text(
                  lan.getTexts("drawer_name"),
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildListTile(Icons.restaurant,lan.getTexts("drawer_item1"), () {
                navigateTo(context, LayoutScreen());
              }, context),
              buildListTile(Icons.settings, lan.getTexts("drawer_item2"), () {
                navigateTo(context,  FilterScreen());
              }, context),
              buildListTile(Icons.color_lens_outlined, lan.getTexts("drawer_item3"), () {
                navigateTo(context,  ThemesScreen());
              }, context),
              const Divider(
                height: 10,
                color: Colors.black54,
              ),
              Container(
                alignment:lan.isEn? Alignment.centerLeft:Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  lan.getTexts("drawer_switch_title"),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      lan.getTexts("drawer_switch_item1"),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Switch(
                      value: lan.isEn,
                      onChanged: (value) =>
                          Provider.of<LanguageProvider>(context, listen: false)
                              .changeLan(value),
                      inactiveTrackColor:
                          Provider.of<ThemeProvider>(context, listen: true).tm ==
                                  ThemeMode.light
                              ? null
                              : Colors.black87,
                    ),
                    Text(
                      lan.getTexts("drawer_switch_item2"),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 10,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
