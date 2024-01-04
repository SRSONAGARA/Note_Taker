import 'package:flutter/material.dart';
import '../../../dashboard/presentation/screen/home_screen.dart';
import '../../../register/presentation/screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/Login-Screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    isObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello!',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Card(
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          border: InputBorder.none,
                          prefixIcon:
                              Icon(Icons.email_outlined, color: Colors.orange),
                          hintText: 'Enter your E-mail'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email can't empty";
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                            .hasMatch(value!)) {
                          return "Enter Correct email";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: TextFormField(
                      obscureText: isObscure,
                      controller: passwordController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Colors.orange),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              icon: isObscure
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          hintText: 'Enter your Password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password can't empty";
                        } else if (value.length < 6) {
                          return "Password is not less than 6 letter";
                        }
                        return null;
                      },
                    ),
                  ),
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text('Forgot your Password?')),
                    ],
                  ),*/
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFE6902)),
                      onPressed: () async {
                        Navigator.of(context).pushNamed(HomeScreen.routeName);
                        /*if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                        }*/
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an Account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegistrationScreen.routeName);
                          },
                          child: const Text('Register'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
