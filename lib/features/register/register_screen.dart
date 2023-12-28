import 'package:flutter/material.dart';
import 'package:note_app/features/dashboard/home_screen.dart';
import 'package:note_app/features/login/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = '/Registration-Screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Note App',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 40),
                  Card(
                    child: TextFormField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          border: InputBorder.none,
                          prefixIcon:
                              Icon(Icons.person_outline, color: Colors.orange),
                          hintText: 'Enter your Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username can't empty";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                      controller: passwordController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          border: InputBorder.none,
                          prefixIcon:
                              Icon(Icons.lock_outline, color: Colors.orange),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: TextFormField(
                      controller: confirmPasswordController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.orange,
                          ),
                          hintText: 'Re-Enter your Password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirm Password Can't empty";
                        } else if (value.length < 6) {
                          return "Password is not less than 6 letter";
                        } else if (value != passwordController.text) {
                          return "Password not matched";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, HomeScreen.routeName);
                       /* if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                        }*/
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an Account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          child: const Text('Login'))
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
