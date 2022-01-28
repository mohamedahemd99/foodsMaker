import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_applicaion/dummy_data.dart';
import 'package:meal_applicaion/provider/meal_provider.dart';
import 'package:meal_applicaion/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GridView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(25),
          children: Provider.of<MealProvider>(context).avalableCategry.map((e) =>CategoryItem(
            color: e.color,
            id: e.id,
          ),).toList(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent:200,
            childAspectRatio: 3/2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
          )
      ),
    );
  }
}
