import 'package:flutter/material.dart';
import 'package:flutter_project_1/UI/utils/app_color.dart';
import 'package:flutter_project_1/UI/widgets/recipe_tile.dart';
import 'package:flutter_project_1/data/models/recipe.dart';

class RecipeListScreen extends StatelessWidget {
  final List<Recipe> recipes;
  final String title;
  final bool showBackButton;

  const RecipeListScreen({
    super.key,
    required this.recipes,
    this.title = 'Recipes',
    this.showBackButton = false,
  });
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
        // show back button only when requested
        leading: showBackButton
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        automaticallyImplyLeading: showBackButton,
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
