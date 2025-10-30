import 'dart:convert';
import 'dart:developer';

import 'package:flutter_project_1/data/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeRepository {
  static Future<List<Recipe>> fetchRecipes() async {
    var response = await http.get(
      Uri.parse('https://dummyjson.com/recipes'),
    );
    log(response.body);
    var data = jsonDecode(response.body);
    List<Recipe> recipes = [];
    for (Map map in data['recipes']) {
      Recipe model = Recipe.fromJson(map);
        recipes.add(model);
    }
    return recipes;
  }
}