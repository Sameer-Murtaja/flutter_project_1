import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_1/UI/screens/login_screen.dart';
import 'package:flutter_project_1/UI/screens/main_nav_screen.dart';
import 'package:flutter_project_1/UI/utils/app_color.dart';
import 'package:flutter_project_1/UI/widgets/custom_text_field.dart';
import 'package:flutter_project_1/UI/widgets/custom_filled_button.dart';
import 'package:flutter_project_1/cubit/auth_cubit.dart';
import 'package:flutter_project_1/cubit/auth_states.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailCont = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (BuildContext context, state) {
        if (state is AuthSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MainNavScreen();
              },
            ),
          );
        } else if (state is AuthErrorState) {
          print(state.errorMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: Duration(milliseconds: 1000),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            children: [
              SizedBox(height: 20),
              // header
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'inter',
                  ),
                ),
              ),
              // Form
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        title: 'Email',
                        controller: emailCont,
                        hint: 'youremail@email.com',
                        validator: (email) {
                          if (!email!.contains('@')) {
                            return 'Email must contain @';
                          }
                          if (!email.contains('.')) {
                            return 'Email must contain .';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        title: 'Full Name',
                        controller: nameController,
                        hint: 'Your Full Name',
                        validator: (name) {
                          return name!.length >= 3 ? null : 'Enter Valid Name';
                        },
                        margin: EdgeInsets.only(top: 16),
                      ),
                      CustomTextField(
                        title: 'Password',
                        controller: passwordController,
                        hint: '**********',
                        obsecureText: true,
                        validator: (password) {
                          if (password!.length >= 8) return null;
                          return 'Weak Password';
                        },
                        margin: EdgeInsets.only(top: 16),
                      ),
                      CustomTextField(
                        title: 'Retype Password',
                        controller: confirmPasswordController,
                        hint: '**********',
                        obsecureText: true,
                        validator: (confirmPassword) {
                          if (confirmPassword == passwordController.text &&
                              confirmPassword!.isNotEmpty) {
                            return null;
                          }
                          return 'Password must match';
                        },
                        margin: EdgeInsets.only(top: 16),
                      ),
                    ],
                  ),
                ),
              ),
              // Signup Button
              SizedBox(height: 32),
              CustomFilledButton(
                text: "Sign up",
                onPressed: () => _signup(context),
              ),
              SizedBox(height: 6),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  //primary: Colors.white,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Have an account? ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'inter',
                        ),
                        text: 'Log in',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signup(
        nameController.text,
        emailCont.text,
        passwordController.text,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Enter Valid Credentials'),
          duration: Duration(milliseconds: 500),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
