import 'package:flutter/material.dart';
import 'package:shop_app/models/meal.dart';

import '../widgets/meal_item.dart';
import '../widgets/category_item.dart';
import '../models/dummy_data.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = 'CategoryMealScreen';
  final List<Meal>? availableMeals;
  CategoryMealScreen({this.availableMeals});

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String? title;
  List<Meal>? displayMeals;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as CategoryItem;
    title = args.title;
    final id = args.id;
    displayMeals = widget.availableMeals!.where(
      (meal) {
        return meal.categories!.contains(id);
      },
    ).toList();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayMeals!.removeWhere(
        (meal) {
          return meal.id == mealId;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeals![index].id as String,
            title: displayMeals![index].title,
            imageUrl: displayMeals![index].imageUrl,
            complexity: displayMeals![index].complexity,
            affordability: displayMeals![index].affordability,
            duration: displayMeals![index].duration,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayMeals!.length,
      ),
    );
  }
}
