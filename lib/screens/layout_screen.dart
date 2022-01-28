import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_applicaion/provider/language_provider.dart';
import 'package:meal_applicaion/provider/meal_provider.dart';
import 'package:meal_applicaion/provider/theme_provider.dart';
import 'package:meal_applicaion/screens/category_screen.dart';
import 'package:meal_applicaion/screens/favorite_screen.dart';
import 'package:meal_applicaion/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key key}) : super(key: key);

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    Provider.of<MealProvider>(context,listen: false).getData();
    Provider.of<MealProvider>(context,listen: false).getCategoryData();
    Provider.of<ThemeProvider>(context,listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context,listen: false).getThemeColor();
    Provider.of<LanguageProvider>(context,listen: false).getLan();
    super.initState();
  }

  final List<Widget> _page = [CategoryScreen(), FavoritesScreen()];

  int _selectedPage = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            title: _selectedPage == 0
                ?  Text(lan.getTexts("categories"))
                :  Text(lan.getTexts("your_favorites"))),
        body: _page[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) => _selectPage(value),
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).accentColor,
            unselectedItemColor: Colors.white,
            currentIndex: _selectedPage,
            items:  [
              BottomNavigationBarItem(
                icon: const Icon(Icons.category),
                title: Text(lan.getTexts("categories"),style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite),
                title: Text(lan.getTexts("your_favorites"),style: const TextStyle(fontWeight: FontWeight.bold),),
              ),
            ]),
        drawer: const MainDrawer(),
      ),
    );
  }
}
