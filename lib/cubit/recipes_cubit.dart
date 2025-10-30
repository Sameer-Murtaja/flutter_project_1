import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_1/data/models/recipe.dart';
import 'package:flutter_project_1/data/recipe_repository.dart';

class RecipesCubit extends Cubit<List<Recipe>> {
  RecipesCubit() : super([]);

  List<Recipe> filterByIdList(List<int> bookmarkedIds) {
    return state.where((recipe) => bookmarkedIds.contains(recipe.id)).toList();
  }

  List<Recipe> filterByMealType(String mealType) {
    return state.where((recipe) => recipe.mealType.contains(mealType)).toList();
  }

  fetchRecipesFromApi() async {
    emit(await RecipeRepository.fetchRecipes());
  }

}
