import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_app/common/color_constant.dart';
import 'package:note_app/features/register/presentation/cubits/register_cubit.dart';
import 'package:note_app/features/register/presentation/cubits/register_state.dart';
import '../../../login/presentation/screen/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = '/Registration-Screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<RegistrationCubit>().togglePswVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.orangeColor100,
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
                    'Welcome',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 40),
                  Card(
                    child: TextFormField(
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person_outline,
                              color: ColorConstants.orangeColor),
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
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.email_outlined,
                              color: ColorConstants.orangeColor),
                          hintText: 'Enter your E-mail'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email can't empty";
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                            .hasMatch(value)) {
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
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.lock_outline,
                              color: ColorConstants.orangeColor),
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
                      obscureText: context
                          .select((RegistrationCubit cubit) => cubit.isObscure),
                      controller: confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: ColorConstants.orangeColor,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<RegistrationCubit>()
                                    .togglePswVisibility();
                              },
                              icon: Icon(context.select(
                                      (RegistrationCubit cubit) =>
                                          cubit.isObscure)
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
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
                  BlocConsumer<RegistrationCubit, RegistrationState>(
                      builder: (context, state) {
                    if (state is RegistrationLoadingState) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.primaryColor),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            BlocProvider.of<RegistrationCubit>(context)
                                .registerApiCall(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                          }
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: ColorConstants.whiteColor,
                              fontWeight: FontWeight.bold),
                        ));
                  }, listener: (context, state) {
                    if (state is RegistrationSuccessState) {
                      String msg = state.msg;
                      Fluttertoast.cancel();
                      Fluttertoast.showToast(
                          gravity: ToastGravity.BOTTOM, msg: msg);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.routeName, (route) => false);
                    } else if (state is RegistrationErrorState) {
                      String msg = state.msg;
                      Fluttertoast.cancel();
                      Fluttertoast.showToast(
                          gravity: ToastGravity.BOTTOM, msg: msg);
                    }
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an Account?",
                        style: TextStyle(color: ColorConstants.blackColor),
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
