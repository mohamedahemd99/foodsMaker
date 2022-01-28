import 'package:flutter/material.dart';
import 'package:meal_applicaion/models/meal.dart';
import 'package:meal_applicaion/provider/meal_provider.dart';
import 'package:meal_applicaion/widgets/meal_item.dart';
import 'package:meal_applicaion/widthandheight.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final List<Meal> favoriteMeals =
        Provider.of<MealProvider>(context, listen: true).favoriteMeals;
    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text("You have no favorites yet - start adding some!"),
      );
    } else {
      return GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: getwidth(context) <= 400 ? 400 : 500,
          childAspectRatio: isLandscape?getwidth(context) /getwidth(context) *1.15:getwidth(context) /getwidth(context) *1.43,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,

        ),
        itemBuilder: (context, index) {
          return MealItem(
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            complexity: favoriteMeals[index].complexity,
            id: favoriteMeals[index].id,
            affordability: favoriteMeals[index].affordability,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
