import 'package:flutter/material.dart';
import 'package:flutter_project_1/UI/utils/app_color.dart';
import 'package:flutter_project_1/UI/widgets/recipe_tile.dart';
import 'package:flutter_project_1/data/models/recipe.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key, required this.title, required this.recipes});
  final List<Recipe> recipes;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      //should i transfer this logic somewhere else? answer:
      body: Container(
        padding: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          itemCount: recipes.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 16);
          },
          itemBuilder: (context, index) {
            return RecipeTile(data: recipes[index]);
          },
        ),
      ),
    );
  }
}
