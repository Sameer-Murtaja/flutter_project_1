import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_1/UI/screens/recipe_list_screen.dart';
import 'package:flutter_project_1/UI/screens/home_screen.dart';
import 'package:flutter_project_1/UI/utils/app_color.dart';
import 'package:flutter_project_1/cubit/auth_cubit.dart';
import 'package:flutter_project_1/cubit/auth_states.dart';
import 'package:flutter_project_1/cubit/recipes_cubit.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainAppState();
}

class _MainAppState extends State<MainNavScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: index == 0
            ? HomeScreen()
            : BlocBuilder<AuthCubit, AuthStates>(
                builder: (context, state) {
                  if (state is AuthSuccessState) {
                    var bookmarkedRecipes = context
                        .read<RecipesCubit>()
                        .filterByIdList(state.user.bookmarksIds);
                    return RecipeListScreen(title: 'Bookmarks', recipes: bookmarkedRecipes);
                  }
                  return Container();
                },
              ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: AppColor.primary,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            activeIcon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark_outlined),
            label: 'Bookmarks',
          ),
        ],
      ),
    );
  }
}
