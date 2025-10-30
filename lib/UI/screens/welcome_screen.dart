import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_1/UI/screens/login_screen.dart';
import 'package:flutter_project_1/UI/screens/main_nav_screen.dart';
import 'package:flutter_project_1/UI/screens/signup_screen.dart';
import 'package:flutter_project_1/UI/utils/app_color.dart';
import 'package:flutter_project_1/UI/widgets/custom_filled_button.dart';
import 'package:flutter_project_1/cubit/auth_cubit.dart';
import 'package:flutter_project_1/cubit/auth_states.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();
  }

  void checkIfLoggedIn() async {
    await null;
    context.read<AuthCubit>().checkIfLoggedIn();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
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
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Hungry?',
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Help you when you're hungry",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Positioned(
                bottom: 32,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    CustomFilledButton(
                      text: "Sign up",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignupScreen();
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: OutlinedButton(
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
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(
                            color: AppColor.secondary.withAlpha(50),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: AppColor.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'inter',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
