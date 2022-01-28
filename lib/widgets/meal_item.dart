import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:meal_applicaion/models/meal.dart';
import 'package:meal_applicaion/provider/language_provider.dart';
import 'package:meal_applicaion/screens/meal_details.dart';
import 'package:meal_applicaion/widgets/category_item.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {
  final String imageUrl;
  final String id;
  final int duration;
  final Complexity complexity;

  final Affordability affordability;

  MealItem(
      {
      @required this.imageUrl,
      @required this.duration,
      @required this.complexity,
      @required this.id,
      @required this.affordability});

  // ignore: missing_return

  // ignore: missing_return

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return InkWell(
      onTap: () {
        navigateTo(
            context,
            MealDetailsScreen(
              mealId: id,
            ));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4.0,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Hero(
                          tag: id,
                          child:  InteractiveViewer(
                            child: FadeInImage(
                              height:double.infinity ,
                              placeholder: const AssetImage("assets/a2.png"),
                              image: AssetImage(imageUrl),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ))),
                  Positioned(
                      bottom: 20,
                      right: 10,
                      child: Container(
                        color: Colors.black45,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(
                          lan.getTexts("meal-$id"),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      )),
                  // Text(title,style: Theme.of(context).textTheme.headline3,)
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            // ignore: deprecated_member_use
                            color: Theme.of(context).buttonColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${duration.toString()} ${lan.getTexts("min")}",
                            style: Theme.of(context).textTheme.caption.copyWith(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.work,
                            // ignore: deprecated_member_use
                            color: Theme.of(context).buttonColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Text(
                            lan.getTexts("$complexity"),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                          ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.attach_money_outlined,
                            // ignore: deprecated_member_use
                            color: Theme.of(context).buttonColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Text(
                            lan.getTexts("$affordability"),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
