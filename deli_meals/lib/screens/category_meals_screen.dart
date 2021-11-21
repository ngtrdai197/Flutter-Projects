import 'package:deli_meals/models/meal_model.dart';
import 'package:deli_meals/widgets/meal_item.dart';
import 'package:flutter/material.dart';

import '../dummy_data.dart';

// ignore: must_be_immutable
class CategoryMealsScreen extends StatefulWidget {
  List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late String categoryId;
  bool _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedInitData) {
      final dynamic routeArgs = ModalRoute.of(context)?.settings.arguments;
      categoryTitle = routeArgs['title'] ?? '';
      categoryId = routeArgs['id'] ?? '';
      widget.availableMeals = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
  }

  void _removeItem(String mealId) {
    setState(() {
      widget.availableMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: widget.availableMeals[index].id,
              title: widget.availableMeals[index].title,
              imageUrl: widget.availableMeals[index].imageUrl,
              duration: widget.availableMeals[index].duration,
              complexity: widget.availableMeals[index].complexity,
              affordability: widget.availableMeals[index].affordability,
              removeItem: _removeItem,
            );
          },
          itemCount: widget.availableMeals.length),
    );
  }
}
