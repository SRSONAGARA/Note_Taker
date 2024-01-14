import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_app/features/login/presentation/cubits/login_cubit.dart';
import 'package:note_app/features/login/presentation/cubits/login_state.dart';
import '../../../../common/color_constant.dart';
import '../../../home_screen/presentation/screen/home_screen.dart';
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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginCubit>(context).togglePswVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.orangeColor100,
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
                      obscureText:
                          context.select((LoginCubit cubit) => cubit.isObscure),
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: ColorConstants.orangeColor),
                          suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<LoginCubit>()
                                    .togglePswVisibility();
                              },
                              icon: Icon(context.select(
                                      (LoginCubit cubit) => cubit.isObscure)
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
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
                  BlocConsumer<LoginCubit, LoginState>(
                      builder: (context, state) {
                    if (state is LoginLoadingState) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.primaryColor),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            BlocProvider.of<LoginCubit>(context).loginApiCall(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                              color: ColorConstants.whiteColor,
                              fontWeight: FontWeight.bold),
                        ));
                  }, listener: (context, state) {
                    if (state is LoginSuccessState) {
                      String msg = state.msg;
                      Fluttertoast.showToast(msg: msg);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeScreen.routeName, (route) => false);
                    } else if (state is LoginErrorState) {
                      String msg = state.msg;
                      Fluttertoast.showToast(msg: msg);
                    } else if (state is LoginCredInvalidState) {
                      String msg = state.msg;
                      Fluttertoast.showToast(msg: msg);
                    }
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an Account?",
                        style: TextStyle(color: ColorConstants.blackColor),
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
