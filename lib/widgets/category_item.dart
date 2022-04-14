import 'package:flutter/material.dart';

import '../pages/category_meal_page.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(this.id, this.title, this.color, {Key? key})
      : super(key: key);
  final String id;
  final String title;
  final Color color;

  void selectCategories(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealPage.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategories(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(18.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Text(title, style: Theme.of(context).textTheme.subtitle1),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    );
  }
}
