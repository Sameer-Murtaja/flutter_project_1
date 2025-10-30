import 'package:flutter_project_1/data/models/user.dart';

abstract class AuthStates {}
class AuthInitialState extends AuthStates {}
class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {
  final User user;
  AuthSuccessState(this.user);
}

class AuthErrorState extends AuthStates {
  final String errorMessage;
  AuthErrorState(this.errorMessage);
}
