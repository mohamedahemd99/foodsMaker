import 'package:flutter/material.dart';
import 'package:meal_applicaion/provider/language_provider.dart';
import 'package:meal_applicaion/provider/meal_provider.dart';
import 'package:meal_applicaion/provider/theme_provider.dart';
import 'package:meal_applicaion/screens/layout_screen.dart';
import 'package:meal_applicaion/screens/on_boarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homeScreen=prefs.getBool("watched")??false?LayoutScreen():const OnBoardingScreen();
  runApp(
    MultiProvider(
        providers:[
          ChangeNotifierProvider<MealProvider>(
            create: (context) => MealProvider(),
          ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider(),
          ),
        ],
      child:  MyApp(homeScreen),
    )
  );
}
class MyApp extends StatelessWidget {
 final Widget homeScreen;
    const MyApp(this.homeScreen, {Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var primaryColor=Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var accentColor=Provider.of<ThemeProvider>(context,listen: true).accentColor;
    var tm=Provider.of<ThemeProvider>(context,listen: true).tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      theme: ThemeData(
        primarySwatch: primaryColor,
        // ignore: deprecated_member_use
        accentColor: accentColor,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        // ignore: deprecated_member_use
        buttonColor: Colors.black87,
        cardColor: Colors.white,
        shadowColor:Colors.white60,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              headline6: const TextStyle(
                  fontSize: 20,
                  fontFamily: "RobotoCondensed",
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
      ),
      darkTheme: ThemeData(
        // ignore: deprecated_member_use
        primarySwatch: primaryColor,
        // ignore: deprecated_member_use
        accentColor: accentColor,
        canvasColor: const Color.fromRGBO(14, 22, 33, 1),
        fontFamily: 'Raleway',
        // ignore: deprecated_member_use
        buttonColor: Colors.white70,
        cardColor: const Color.fromRGBO(35, 34, 39, 1),
        shadowColor:  Colors.black54,
        unselectedWidgetColor: Colors.white70,
        textTheme: ThemeData.dark().textTheme.copyWith(
          bodyText1: const TextStyle(
            color: Colors.white60,
          ),
          bodyText2: const TextStyle(
            color: Colors.white60,
          ),
          headline6: const TextStyle(
              fontSize: 20,
              fontFamily: "RobotoCondensed",
              color:Colors.white70,
              fontWeight: FontWeight.bold),
        ),
      ),
      home: const OnBoardingScreen(),
    );
  }
}
