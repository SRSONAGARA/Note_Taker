import 'package:flutter/cupertino.dart';
import 'package:note_app/features/dashboard/home_screen.dart';
import 'package:note_app/features/login/login_screen.dart';
import 'package:note_app/features/register/register_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> get getAppRoutes => {
    RegistrationScreen.routeName: (_)=> const RegistrationScreen(),
    LoginScreen.routeName: (_)=> const LoginScreen(),
    HomeScreen.routeName: (_)=> const HomeScreen(),
  };
}
