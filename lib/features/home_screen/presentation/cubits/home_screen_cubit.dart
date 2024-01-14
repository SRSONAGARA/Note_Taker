import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/common/api_constant.dart';
import 'package:note_app/features/home_screen/data/getAllNote_model_class.dart';
import 'package:note_app/features/home_screen/presentation/cubits/home_screen_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitialState());

  GetAllNoteModelClass getAllNoteModelClass = GetAllNoteModelClass();

  List<dynamic> filteredNotes = [];

  Future<void> getAllNoteApi() async {
    try {
      emit(HomeScreenLoadingState());
      String url = ApiConstant.getAllNoteApi;
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      var response = await http
          .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        getAllNoteModelClass =
            GetAllNoteModelClass.fromJson(jsonDecode(response.body));
        filteredNotes = getAllNoteModelClass.data ?? [];
        emit(HomeScreenSuccessState());
      } else {
        getAllNoteModelClass =
            GetAllNoteModelClass.fromJson(jsonDecode(response.body));
        emit(HomeScreenErrorState());
      }
    } catch (e) {
      print(e);
    }
  }

  void filterNotes(String query) {
    if (query.isEmpty) {
      filteredNotes = getAllNoteModelClass.data ?? [];
    } else {
      filteredNotes = getAllNoteModelClass.data!
          .where((note) =>
              (note.title!.toLowerCase().contains(query.toLowerCase())))
          .toList();
    }
    emit(HomeScreenFilteredState());
  }
}
