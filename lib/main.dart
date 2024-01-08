import 'package:flutter/material.dart';
import 'package:note_app/common/color_constant.dart';
import 'package:note_app/config/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/home_screen/presentation/screen/home_screen.dart';
import 'features/login/presentation/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await checkToken();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

Future<bool> checkToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString('token');
  return token != null && token.isNotEmpty;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme:
            const ColorScheme.light(primary: ColorConstants.primaryColor),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: ColorConstants.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 20)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme:
            const ColorScheme.dark(primary: ColorConstants.primaryColor)
                .copyWith(brightness: Brightness.dark),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: ColorConstants.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 20)),
      ),
      themeMode: ThemeMode.system,
      initialRoute: isLoggedIn ? HomeScreen.routeName : LoginScreen.routeName,
      routes: AppRoutes.getAppRoutes,
    );
  }
}
