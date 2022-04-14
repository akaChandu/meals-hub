import 'package:flutter/material.dart';

import './dummy_data.dart';
import './pages/filters_page.dart';
import './pages/tabs_page.dart';
import './pages/meal_detail_page.dart';
import './pages/category_meal_page.dart';
import './pages/categories_page.dart';
import './models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void _saveFilters(Map<String, bool> filterData) {
    setState(
      () {
        _filters = filterData;
        availableMeals = DUMMY_MEALS.where(
          ((meal) {
            if (_filters['gluten']! && !meal.isGlutenFree) {
              return false;
            }
            if (_filters['lactose']! && !meal.isLactoseFree) {
              return false;
            }
            if (_filters['vegan']! && !meal.isVegan) {
              return false;
            }
            if (_filters['vegetarian']! && !meal.isVegetarian) {
              return false;
            }
            return true;
          }),
        ).toList();
      },
    );
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        favoriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(
        () {
          favoriteMeals.removeAt(existingIndex);
        },
      );
    } else {
      setState(
        () {
          favoriteMeals
              .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
        },
      );
    }
  }

  bool _isMealFavorite(String id) {
    return favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals Hub',
      theme: ThemeData(
        // primarySwatch: Colors.pink,
        // accentColor: Colors.amber,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
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
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: const CategoriesPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsPage(favoriteMeals),
        CategoryMealPage.routeName: (context) =>
            CategoryMealPage(availableMeals),
        MealDetailPage.routeName: (context) =>
            MealDetailPage(_toggleFavorite, _isMealFavorite),
        FiltersPage.routeName: (context) => FiltersPage(_filters, _saveFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (context) => const CategoriesPage());
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(
          builder: ((context) => const CategoriesPage()),
        );
      },
    );
  }
}
