// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
import 'package:meal_applicaion/provider/language_provider.dart';
import 'package:meal_applicaion/provider/meal_provider.dart';
import 'package:meal_applicaion/provider/theme_provider.dart';
import 'package:meal_applicaion/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FilterScreen extends StatefulWidget {
  static const routeName = 'filterScreen';
  bool fromOnBoarding;

  FilterScreen({Key key, this.fromOnBoarding = false}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Widget builtSwitchListTile(
          {String title, String subTitle, bool value, Function onchange}) =>
      SwitchListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        value: value,
        onChanged: onchange,
        inactiveTrackColor:
            Provider.of<ThemeProvider>(context).tm == ThemeMode.light
                ? null
                : Colors.black87,
      );

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilter =
        Provider.of<MealProvider>(context, listen: true).filters;
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: false,
              title: widget.fromOnBoarding?null:Text(lan.getTexts("filters_appBar_title")),
              elevation: widget.fromOnBoarding?0.0:5.0,
              backgroundColor: widget.fromOnBoarding? Theme.of(context).canvasColor:Theme.of(context).primaryColor,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(20),
                child: Text(lan.getTexts("filters_screen_title"),
                    style: Theme.of(context).textTheme.headline6),
              ),
              builtSwitchListTile(
                  title: lan.getTexts("Gluten-free"),
                  subTitle: lan.getTexts("Gluten-free-sub"),
                  value: currentFilter['gluten'],
                  onchange: (value) {
                    setState(() {
                      currentFilter['gluten'] = value;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  }),
              builtSwitchListTile(
                  title: lan.getTexts("Vegan"),
                  subTitle: lan.getTexts("Vegan-sub"),
                  value: currentFilter['vegan'],
                  onchange: (value) {
                    setState(() {
                      currentFilter['vegan'] = value;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  }),
              builtSwitchListTile(
                  title: lan.getTexts("Vegetarian"),
                  subTitle: lan.getTexts("Vegetarian-sub"),
                  value: currentFilter['vegetarian'],
                  onchange: (value) {
                    setState(() {
                      currentFilter['vegetarian'] = value;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  }),
              builtSwitchListTile(
                  title: lan.getTexts("Lactose-free"),
                  subTitle: lan.getTexts("Lactose-free_sub"),
                  value: currentFilter['lactose'],
                  onchange: (value) {
                    setState(() {
                      currentFilter['lactose'] = value;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  }),
              SizedBox(
                height: widget.fromOnBoarding ? 100 : 0.0,
              )
            ]))
          ],
        ),
        drawer: widget.fromOnBoarding?null:const MainDrawer(),
      ),
    );
  }
}
