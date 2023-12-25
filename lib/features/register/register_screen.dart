import 'package:flutter/material.dart';

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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign in',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 40),
                Card(
                  child: TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person_outline),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.email_outlined),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock_outline),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock_outline),
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
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        // await Future.delayed(const Duration(seconds: 1));
                        // await Navigator.pushNamed(context, '/otp-screen');
                      }
                    },
                    child: const Text('Sign Up')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
