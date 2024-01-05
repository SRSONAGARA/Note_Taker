import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/common/api_constant.dart';
import 'package:note_app/features/register/data/register_model_class.dart';
import 'package:note_app/features/register/presentation/cubits/register_state.dart';
import 'package:http/http.dart' as http;

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitialState());
  bool isObscure = false;
  void togglePswVisibility(){
    isObscure = !isObscure;
    emit(PswVisibilityChangeState(isObscure: isObscure));
  }

  Future<void> registerApiCall(
      {required String name,
      required String email,
      required String password}) async {
    try {
      emit(RegistrationLoadingState());
      String url = ApiConstant.registrationApi;
      var requestBody = {'name': name, 'email': email, 'password': password};
      var response = await http.post(Uri.parse(url), body: requestBody);
      print(response.statusCode);

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        emit(RegistrationSuccessState(msg: responseBody['message']));
      } else if (response.statusCode == 400) {
        final responseBody = jsonDecode(response.body);
        emit(RegistrationErrorState(msg: responseBody['message']));
      }
    } catch (e) {
      print(e);
    }
  }
}
