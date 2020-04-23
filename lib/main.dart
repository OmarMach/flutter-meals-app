import 'package:flutter/material.dart';
import 'package:meals_app/Screens/filters_screen.dart';
import 'package:meals_app/Screens/meal_detail_screen.dart';
import 'package:meals_app/Screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import 'Models/meal.dart';
import 'dummy_data.dart.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  Map<String, Object> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };

  bool _isFavouriteMeals(String id ){
    return favoriteMeals.any((meal) => meal.id ==id );
  }
  void _setFilter(Map<String, Object> filters) {
    setState(() {
      _filters = filters;
      availableMeals = availableMeals.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        if (_filters['vegeterian'] && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFav(String mealId){
    final existIndex = favoriteMeals.indexWhere((meal) => mealId == meal.id);
    if( existIndex  >= 0) setState(() {
      favoriteMeals.removeAt(existIndex);
    }); 
    else
    setState(() {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The menu.',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(fontSize: 24, fontFamily: 'RobotoCondensed'))),
      home: TabsScreen(favoriteMeals),
      routes: {
        MealDetailScreen.route: (context) => MealDetailScreen(_toggleFav,_isFavouriteMeals),
        CategoryMealsScreen.route: (context) =>
            CategoryMealsScreen(availableMeals),
        FiltersScreen.route: (context) => FiltersScreen(
          currentFilters: _filters,
              saveFilters: _setFilter,
            ),
      },
    );
  }
}
