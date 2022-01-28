import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;
  var tm = ThemeMode.system;

  String themeText='s';


  themeModeChange(newThemeMode)async {
    tm = newThemeMode;
    _getThemeText(tm);
    notifyListeners();

    SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.setString("themeText",themeText);
  }

  _getThemeText(ThemeMode tm){
    if(tm==ThemeMode.dark) {
      themeText='d';
    }
    else if(tm==ThemeMode.light) {
      themeText='l';
    }
    else if(tm==ThemeMode.system) {
      themeText='s';
    }
  }

  getThemeMode()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    themeText=preferences.getString("themeText")??"s";
    if(themeText=='d') {
      tm=ThemeMode.dark;
    }
    else if(themeText=='l') {
      tm=ThemeMode.light;
    }
    else if(themeText=='s') {
      tm=ThemeMode.system;
    }
    notifyListeners();

  }

  onChange(color,n)async{
    n==1?primaryColor=_toMaterial(color.hashCode):
        accentColor=_toMaterial(color.hashCode);
    notifyListeners();
    SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.setInt("primaryColor",primaryColor.value);
    preferences.setInt("accentColor",accentColor.value);
  }

  getThemeColor()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    primaryColor=_toMaterial(preferences.getInt("primaryColor")??0xFFE91E63);
    accentColor=_toMaterial(preferences.getInt("accentColor")??0xFFFFC107);
    notifyListeners();

  }

  MaterialColor _toMaterial(colorVal) {
    return MaterialColor(colorVal, <int, Color>{
      50: const Color(0xFFFFEBEE),
      100: const Color(0xFFFFCDD2),
      200: const Color(0xFFEF9A9A),
      300: const Color(0xFFE57373),
      400: const Color(0xFFEF5350),
      500: Color(colorVal),
      600: const Color(0xFFE53935),
      700: const Color(0xFFD32F2F),
      800: const Color(0xFFC62828),
      900: const Color(0xFFB71C1C),
    });
  }


}


