import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_1/UI/screens/welcome_screen.dart';
import 'package:flutter_project_1/cubit/auth_cubit.dart';
import 'package:flutter_project_1/cubit/recipes_cubit.dart';
import 'package:flutter_project_1/data/auth_shared_db.dart';
import 'package:flutter_project_1/data/recipes_app_sqlite_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RecipesAppSqliteDb.init();
  await AuthSharedDb.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) => RecipesCubit()..fetchRecipesFromApi(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),
    ),
  );
}
