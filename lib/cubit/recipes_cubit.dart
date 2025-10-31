import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_1/data/models/recipe.dart';
import 'package:flutter_project_1/data/recipe_repository.dart';
import 'package:flutter_project_1/cubit/recipes_states.dart';

class RecipesCubit extends Cubit<RecipesStates> {
  RecipesCubit() : super(RecipesLoadingState());

  List<Recipe> filterByIdList(List<int> bookmarkedIds) {
    if(state is! RecipesSuccessState) {
      return [];
    }else{
      return (state as RecipesSuccessState).recipes.where((recipe) => bookmarkedIds.contains(recipe.id)).toList();
    }
  }

  List<Recipe> filterByMealType(String mealType) {
    if(state is! RecipesSuccessState) {
      return [];
    }else{
      return (state as RecipesSuccessState).recipes.where((recipe) => recipe.mealType.contains(mealType)).toList();
    }
  }

  fetchRecipesFromApi() async {
    emit(RecipesLoadingState());
    try {
      final fetched = await RecipeRepository.fetchRecipes();
      emit(RecipesSuccessState(List<Recipe>.from(fetched)));
    } catch (e) {
      emit(RecipesErrorState(e.toString()));
    }
  }
}
