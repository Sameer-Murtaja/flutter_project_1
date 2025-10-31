import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_1/UI/screens/recipe_list_screen.dart';
import 'package:flutter_project_1/cubit/recipes_cubit.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final ImageProvider image;

  const CategoryCard({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              var filteredRecipes = context.read<RecipesCubit>().filterByMealType(title);
              return RecipeListScreen(title: title, recipes: filteredRecipes, showBackButton: true);
            },
          ),
        );
      },
      child: Container(
        width:
            ((MediaQuery.of(context).size.width - 16 - 16) / 2) - 8,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // Image
          image: DecorationImage(image: image, fit: BoxFit.cover),
        ),
        child: Container(
          width: 164,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Color(0xFF062D2B).withAlpha(102)),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'inter',
            ),
          ),
        ),
      ),
    );
  }
}
