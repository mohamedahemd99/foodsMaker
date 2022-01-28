class Meal{
  final String id;
  final List<String> categories;
  final String imageUrl;
  final int duration;
  final Complexity complexity  ;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;

  Meal({this.id, this.categories, this.imageUrl, this.duration, this.complexity, this.affordability, this.isGlutenFree, this.isVegan, this.isVegetarian, this.isLactoseFree});
  }


  enum Affordability{
  Affordable,
    Pricey,
    Luxurious,
  }
  enum Complexity{
  Simple,
    Challenging,
    Hard,
  }