import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/register/presentation/cubits/register_bloc.dart';
import '../../features/dashboard/presentation/screen/home_screen.dart';
import '../../features/login/presentation/screen/login_screen.dart';
import '../../features/new_note/presentation/screen/new_note_screen.dart';
import '../../features/register/presentation/screen/register_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> get getAppRoutes => {
        RegistrationScreen.routeName: (_) => BlocProvider<RegistrationCubit>(
            create: (_) => RegistrationCubit(),
            child: const RegistrationScreen()),
        LoginScreen.routeName: (_) => const LoginScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        AddNoteScreen.routeName: (_) => const AddNoteScreen(),
      };
}
