import 'package:flutter/material.dart';
import 'package:meal_applicaion/models/category.dart';
import 'package:meal_applicaion/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<String> prefsMealId = [];

  List<Meal> favoriteMeals = [];

  List<Meal> avalableMeals = DUMMY_MEALS;

  List<Category> avalableCategry = [];

  void getCategoryData(){
    List<Category> ac = [];
    for (var meal in avalableMeals) {
      for (var catId in meal.categories) {
        for (var cat in DUMMY_CATEGORIES) {
          if (cat.id == catId && !ac.any((cat) => cat.id == catId)) {
            ac.add(cat);
          }
        }
      }
    }
    avalableCategry=ac;
  }

  void setFilters() async {
    avalableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose'] && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan'] && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian'] && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    getCategoryData();

    notifyListeners();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("gluten", filters['gluten']);
    preferences.setBool("lactose", filters['lactose']);
    preferences.setBool("vegan", filters['vegan']);
    preferences.setBool("vegetarian", filters['vegetarian']);
  }

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    filters['gluten'] = preferences.getBool("gluten") ?? false;
    filters['lactose'] = preferences.getBool("lactose") ?? false;
    filters['vegan'] = preferences.getBool("vegan") ?? false;
    filters['vegetarian'] = preferences.getBool("vegetarian") ?? false;

    prefsMealId = preferences.getStringList("prefsMealId") ?? [];

    for (var mealId in prefsMealId) {
      final existingIndex =
          favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }
    List<Meal> fm=[];
    favoriteMeals.forEach((favMeals) {
      avalableMeals.forEach((avMeals) {
        if(favMeals.id==avMeals.id)fm.add(favMeals);
      });
    });
    favoriteMeals=fm;
    notifyListeners();
  }

  bool isMealFavorite = false;

  void toggelFavorite(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }
    notifyListeners();

    prefs.setStringList("prefsMealId", prefsMealId);
  }

  bool isFavorite(String mealId) {
    return isMealFavorite = favoriteMeals.any((meal) => meal.id == mealId);
  }
}
