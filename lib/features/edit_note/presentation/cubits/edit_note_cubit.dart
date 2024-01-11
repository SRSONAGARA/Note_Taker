import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/edit_note/presentation/cubits/edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState>{
  EditNoteCubit(): super(EditNoteInitialState());


}