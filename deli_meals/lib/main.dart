import 'package:deli_meals/constants/routes.dart';
import 'package:flutter/material.dart';

import 'dummy_data.dart';
import 'models/meal_model.dart';
import 'screens/category_meals_screen.dart';
import 'screens/filters_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class FilterItem {
  final bool gluten;
  final bool lactose;
  final bool vegan;
  final bool vegetarian;

  FilterItem(
      {required this.gluten,
      required this.lactose,
      required this.vegan,
      required this.vegetarian});
}

class _MyAppState extends State<MyApp> {
  FilterItem _filters = FilterItem(
      gluten: false, lactose: false, vegan: false, vegetarian: false);

  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(FilterItem filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters.gluten && !meal.isGlutenFree) {
          return false;
        }
        if (_filters.lactose && !meal.isLactoseFree) {
          return false;
        }
        if (_filters.vegan && !meal.isVegan) {
          return false;
        }
        if (_filters.vegetarian && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.purple[900],
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            headline6: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      initialRoute: DAINTROUTING.CATEGORIES,
      routes: {
        DAINTROUTING.CATEGORIES: (context) => TabsScreen(),
        DAINTROUTING.CATEGORY_MEALS: (context) =>
            CategoryMealsScreen(_availableMeals),
        DAINTROUTING.MEAL_DETAIL: (context) => MealDetailScreen(),
        DAINTROUTING.FILTERS: (context) => FiltersScreen(
              saveFilters: _setFilters,
              currentFilters: _filters,
            )
      },
    );
  }
}
