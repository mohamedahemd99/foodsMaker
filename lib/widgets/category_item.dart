
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meal_applicaion/provider/language_provider.dart';
import 'package:meal_applicaion/screens/meal_screen.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final Color color;
  final String id;

  CategoryItem({ this.id, this.color,}) ;
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return InkWell(
      onTap: (){
        navigateTo(context, MealScreen(catId: id,));
      },
      borderRadius: BorderRadius.circular(10),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        child: Center(child: Text(lan.getTexts("cat-$id"),style: Theme.of(context).textTheme.headline6,)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              colors:[
                color.withOpacity(0.6),
                color,
              ],
            begin:Alignment.topLeft ,
            end: Alignment.bottomRight,
          )
        ),
      ),
    ) ;
  }
}
void navigateTo(context,widget)=> Navigator.push(context,MaterialPageRoute(builder: (context) => widget,));
