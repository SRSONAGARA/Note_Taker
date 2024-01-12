import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/edit_note/presentation/cubits/edit_note_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../common/api_constant.dart';

class EditNoteCubit extends Cubit<EditNoteState>{
  EditNoteCubit(): super(EditNoteInitialState());

  Future<void> editNoteApi(String id, title, description) async {
    try {
      String url = ApiConstant.editNoteApi;
      var requestBody ={
        "title" : title,
        "description" :description
      };
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      var response = await http
          .put(Uri.parse(url), headers: {"Authorization": "Bearer $token", "noteid":id},body:requestBody );
      print(response.statusCode);
      print(response.body);

    } catch (e) {
      print(e);
    }
  }

}