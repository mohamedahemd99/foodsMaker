// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_applicaion/models/meal.dart';
import 'package:meal_applicaion/provider/language_provider.dart';
import 'package:meal_applicaion/provider/meal_provider.dart';
import 'package:meal_applicaion/widgets/main_drawer.dart';
import 'package:meal_applicaion/widgets/meal_item.dart';
import 'package:provider/provider.dart';

import '../widthandheight.dart';

class MealScreen extends StatefulWidget {
  static const routeName = 'mealScreen';
  final String catId;

  const MealScreen({Key key, this.catId,}) : super(key: key);

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals = Provider
        .of<MealProvider>(context, listen: true)
        .avalableMeals;
    final categoryId = widget.catId;
    displayedMeals = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,

      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getTexts("cat-${widget.catId}")),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: getwidth(context) <= 400 ? 400 : 500,
            childAspectRatio: isLandscape?getwidth(context) /getwidth(context) *1.15:getwidth(context) /getwidth(context) *1.43,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (context, index) =>
              MealItem(
                affordability: displayedMeals[index].affordability,
                complexity: displayedMeals[index].complexity,
                duration: displayedMeals[index].duration,
                imageUrl: displayedMeals[index].imageUrl,
                id: displayedMeals[index].id,
              ),
          itemCount: displayedMeals.length,
        ),
        drawer: const MainDrawer(),
      ),
    );
  }
}
