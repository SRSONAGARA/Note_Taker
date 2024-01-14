import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/common/api_constant.dart';
import 'package:note_app/features/new_note/presentation/cubits/add_note_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitialState());

  Future<void> addNoteApi(String title, String description) async {
    try {
      emit(AddNoteLoadingState());
      String url = ApiConstant.addNoteApi;
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      var requestBody = {'title': title, 'description': description};

      var response = await http.post(Uri.parse(url),
          headers: {"Authorization": "Bearer $token"}, body: requestBody);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        emit(AddNoteSuccessState());
      } else if (response.statusCode == 400) {
        emit(AddNoteTitleDescriptionEmptyState());
      } else {
        emit(AddNoteErrorState());
      }
    } catch (e) {
      print(e);
    }
  }
}
