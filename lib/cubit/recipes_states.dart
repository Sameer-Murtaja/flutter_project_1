import 'package:flutter_project_1/data/models/recipe.dart';

abstract class RecipesStates {}

class RecipesLoadingState extends RecipesStates {}

class RecipesSuccessState extends RecipesStates {
  final List<Recipe> recipes;
  RecipesSuccessState(this.recipes);
}

class RecipesErrorState extends RecipesStates {
  final String errorMessage;
  RecipesErrorState(this.errorMessage);
}
