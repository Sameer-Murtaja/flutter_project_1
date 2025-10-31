import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_1/UI/screens/welcome_screen.dart';
import 'package:flutter_project_1/UI/utils/app_color.dart';
import 'package:flutter_project_1/UI/widgets/category_card.dart';
import 'package:flutter_project_1/UI/widgets/recipe_tile.dart';
import 'package:flutter_project_1/cubit/auth_cubit.dart';
import 'package:flutter_project_1/cubit/recipes_cubit.dart';
import 'package:flutter_project_1/cubit/recipes_states.dart';
import 'package:flutter_project_1/data/models/recipe.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String name = context.read<AuthCubit>().getCurrentUser().name;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Explore Recipes, $name',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined, color: Colors.white),
            onPressed: () {
              context.read<AuthCubit>().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WelcomeScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ListView( 
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: MediaQuery.of(context).size.width,
            height: 245,
            color: AppColor.primary,
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                CategoryCard(
                  title: 'Breakfast',
                  image: AssetImage('assets/healthy.jpg'),
                ),
                CategoryCard(
                  title: 'Lunch',
                  image: AssetImage('assets/meat.jpg'),
                ),
                CategoryCard(
                  title: 'Dinner',
                  image: AssetImage('assets/dinner.webp'),
                ),
                CategoryCard(
                  title: 'Dessert',
                  image: AssetImage('assets/desert.jpg'),
                ),
                CategoryCard(
                  title: 'Appetizer',
                  image: AssetImage('assets/spicy.jpg'),
                ),
                CategoryCard(
                  title: 'Beverage',
                  image: AssetImage('assets/drink.jpg'),
                ),
              ],
            ),
          ),
          BlocBuilder<RecipesCubit, RecipesStates>(
            builder: (BuildContext context, RecipesStates state) {
              if (state is RecipesLoadingState) {
                return Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }

              if (state is RecipesErrorState) {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Failed to load recipes', style: TextStyle(color: Colors.red)),
                      SizedBox(height: 8),
                      Text(state.errorMessage),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context.read<RecipesCubit>().fetchRecipesFromApi(),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              // RecipesSuccessState
              var recipes = <Recipe>[];
              if (state is RecipesSuccessState) recipes = state.recipes;

              return Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  itemCount: recipes.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16);
                  },
                  itemBuilder: (context, index) {
                    return RecipeTile(data: recipes[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
