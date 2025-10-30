import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_1/cubit/auth_states.dart';
import 'package:flutter_project_1/data/auth_shared_db.dart';
import 'package:flutter_project_1/data/models/user.dart';
import 'package:flutter_project_1/data/recipes_app_sqlite_db.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  checkIfLoggedIn() async {
    if (AuthSharedDb.checkloginDataFromSharedDb()) {
      var loginData = AuthSharedDb.fetchLoginDataFromSharedDb();

      login(loginData['email']!, loginData['password']!);
    }
  }

  User getCurrentUser() {
    if (state is AuthSuccessState) {
      return (state as AuthSuccessState).user;
    } else {
      throw Exception('No user is currently logged in');
    }
  }

  List<int> getBookmarkedRecipeIds() {
    return List<int>.from(getCurrentUser().bookmarksIds);
  }

  bool isRecipeBookmarked(int recipeId) {
    var bookmarkedRecipeIds = getBookmarkedRecipeIds();
    return bookmarkedRecipeIds.contains(recipeId);
  }

  toggleBookmark(int recipeId) {
    var bookmarkedRecipeIds = getBookmarkedRecipeIds();
    if (bookmarkedRecipeIds.contains(recipeId)) {
      bookmarkedRecipeIds.remove(recipeId);
    } else {
      bookmarkedRecipeIds.add(recipeId);
    }
    var currentUser = getCurrentUser();
    final updatedUser = User(
      id: currentUser.id,
      name: currentUser.name,
      email: currentUser.email,
      password: currentUser.password,
      bookmarksIds: bookmarkedRecipeIds,
    );

    emit(AuthSuccessState(updatedUser));
    RecipesAppSqliteDb.updateUserBookmarksInDb(
      currentUser.id,
      bookmarkedRecipeIds,
    );
  }

  logout() {
    AuthSharedDb.removeloginDataFromSharedDb();
    emit(AuthInitialState());
  }

    login(String email, String password) async {
    emit(AuthLoadingState());

    try {
      var user = await RecipesAppSqliteDb.loginUser(email, password);
      AuthSharedDb.updateLoginDataAtSharedDb(email, password);
      emit(AuthSuccessState(user));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
      return;
    }
  }

  signup(String name, String email, String password) async {
    emit(AuthLoadingState());

    try {
      var id = await RecipesAppSqliteDb.signupUser(
        User(name: name, email: email, password: password),
      );
      AuthSharedDb.updateLoginDataAtSharedDb(email, password);
      emit(
        AuthSuccessState(
          User(id: id, name: name, email: email, password: password),
        ),
      );
    } catch (e) {
      emit(AuthErrorState(e.toString()));
      return;
    }
  }
}
