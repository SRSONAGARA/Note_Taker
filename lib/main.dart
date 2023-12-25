import 'package:flutter/material.dart';
import 'package:note_app/config/routes/app_routes.dart';
import 'package:note_app/features/register/register_screen.dart';
import 'features/dashboard/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(primary: Color(0xFFFE6902)),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(primary: Color(0xFFFE6902))
            .copyWith(brightness: Brightness.dark),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20)),
      ),
      themeMode: ThemeMode.system,
      initialRoute: RegistrationScreen.routeName,
      routes: AppRoutes.getAppRoutes,
    );
  }
}
