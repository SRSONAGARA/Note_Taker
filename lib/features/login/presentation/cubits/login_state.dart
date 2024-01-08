abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class PswVisibilityChangeState extends LoginState {
  final bool isObscure;
  PswVisibilityChangeState(this.isObscure);
}

class LoginSuccessState extends LoginState {
  final String msg;
  LoginSuccessState({required this.msg});
}

class LoginErrorState extends LoginState {
  final String msg;
  LoginErrorState({required this.msg});
}

class LoginCredInvalidState extends LoginState {
  final String msg;
  LoginCredInvalidState({required this.msg});
}
