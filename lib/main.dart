import 'package:flutter/material.dart';

import './models/dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/favourite_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_screen.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> availableMeals = DUMMY_MEALS;

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;

      availableMeals.where((meal) {
        if (filters['gluten']! && !meal.isGlutenFree!) {
          return false;
        }
        if (filters['lactose']! && !meal.isLactoseFree!) {
          return false;
        }
        if (filters['vegan']! && !meal.isVegan!) {
          return false;
        }
        if (filters['vegetarian']! && !meal.isVegetarian!) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
        primaryColor: Colors.pink,
        secondaryHeaderColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              subtitle1: const TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold),
              subtitle2: const TextStyle(fontFamily: 'Raleway', fontSize: 22.0),
            ),
      ),
      initialRoute: TabsScreen.routeName,
      routes: {
        TabsScreen.routeName: (ctx) => const TabsScreen(),
        CategoryScreen.routeName: (ctx) => const CategoryScreen(),
        CategoryMealScreen.routeName: (ctx) =>
            CategoryMealScreen(availableMeals: availableMeals),
        MealDetailScreen.routeName: (ctx) => const MealDetailScreen(),
        FavouriteScreen.routeName: (ctx) => const FavouriteScreen(),
        FiltersScreen.routeName: (ctx) =>
            FiltersScreen(saveFilters: setFilters),
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(
          builder: (ctx) => const CategoryScreen(),
        );
      },
    );
  }
}
