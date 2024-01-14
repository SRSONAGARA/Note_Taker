import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/common/api_constant.dart';
import 'package:note_app/features/login/presentation/cubits/login_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  bool isObscure = false;

  void togglePswVisibility(){
    isObscure = !isObscure;
    emit(PswVisibilityChangeState(isObscure));
  }

  Future<void> loginApiCall(
      {required String email, required String password}) async {
    try {
      emit(LoginLoadingState());
      String url = ApiConstant.loginApi;
      var requestBody = {'email': email, 'password': password};
      var response = await http.post(Uri.parse(url), body: requestBody);
      print(response.statusCode);
      if(response.statusCode == 200){
        final responseBody = jsonDecode(response.body);
        print(responseBody['data']['token']);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', responseBody['data']['token']);
        emit(LoginSuccessState(msg: responseBody['message']));
      }else if(response.statusCode == 400){
        final responseBody = jsonDecode(response.body);
        emit(LoginErrorState(msg: responseBody['message']));
      } else if(response.statusCode == 401){
        final responseBody = jsonDecode(response.body);
        emit(LoginCredInvalidState(msg: responseBody['message']));
      }
    } catch (e) {
      print(e);
    }
  }
}
