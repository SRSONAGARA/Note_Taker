import 'package:flutter/cupertino.dart';
import 'package:note_app/features/edit_note/presentation/screen/edit_note_screen.dart';
import '../../features/home_screen/presentation/screen/home_screen.dart';
import '../../features/login/presentation/screen/login_screen.dart';
import '../../features/new_note/presentation/screen/add_note_screen.dart';
import '../../features/register/presentation/screen/register_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> get getAppRoutes => {
        RegistrationScreen.routeName: (_) => const RegistrationScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        AddNoteScreen.routeName: (_) => const AddNoteScreen(),
        EditNoteScreen.routeName: (_) => const EditNoteScreen()
      };
}
