// ignore: unnecessary_import
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_applicaion/provider/language_provider.dart';
import 'package:meal_applicaion/provider/meal_provider.dart';
import 'package:meal_applicaion/widgets/main_drawer.dart';
import 'package:meal_applicaion/widthandheight.dart';
import 'package:provider/provider.dart';

import '../dummy_data.dart';

// ignore: must_be_immutable
class MealDetailsScreen extends StatelessWidget {
  static const routeName = 'meal_detail';
  String mealId;

  MealDetailsScreen({Key key, this.mealId}) : super(key: key);

  Widget buildContainer(Widget child, context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        height: 150,
        width: isLandscape ? (getwidth(context) * 0.5 - 20) : getwidth(context),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var selectedItem = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    List<String> liStepLi = lan.getTexts("steps-$mealId") as List<String>;
    var liSteps = ListView.separated(
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          child: Text('#${index + 1}'),
        ),
        title: Text(
          liStepLi[index],
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        thickness: 2,
      ),
      itemCount: liStepLi.length,
    );

    List<String> liIngredientLi =
        lan.getTexts("ingredients-$mealId") as List<String>;
    var liIngredients = ListView.builder(
      itemBuilder: (context, index) => Card(
        elevation: 0,
        // ignore: deprecated_member_use
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            liIngredientLi[index],
            style: const TextStyle(
                color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      itemCount: liIngredientLi.length,
    );
    Widget buildSectionTitle(context, String text) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            lan.getTexts(text),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        );
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.4,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title:Text(lan.getTexts("meal-$mealId")),
                  background:  Hero(
                      tag: mealId,
                      child: InteractiveViewer(
                        child: FadeInImage(
                          placeholder: const AssetImage("assets/a2.png"),
                          image: AssetImage(selectedItem.imageUrl),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([

                if (isLandscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          buildSectionTitle(context, "Ingredients"),
                          buildContainer(liIngredients, context),
                        ],
                      ),
                      Column(
                        children: [
                          buildSectionTitle(context, "Steps"),
                          buildContainer(liSteps, context),
                        ],
                      )
                    ],
                  ),
                if (!isLandscape) buildSectionTitle(context, 'Ingredients'),
                if (!isLandscape) buildContainer(liIngredients, context),
                if (!isLandscape) buildSectionTitle(context, 'Steps'),
                if (!isLandscape) buildContainer(liSteps, context),
                const SizedBox(
                  height: 20,
                ),
              ]))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .toggelFavorite(mealId),
          child: Icon(Provider.of<MealProvider>(context, listen: true)
                  .isFavorite(mealId)
              ? Icons.star
              : Icons.star_border),
          elevation: 0,
        ),
        drawer: const MainDrawer(),
      ),
    );
  }
}
