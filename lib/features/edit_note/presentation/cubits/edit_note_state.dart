abstract class EditNoteState {}

class EditNoteInitialState extends EditNoteState {}

class EditNoteLoadingState extends EditNoteState {}

class EditNoteSuccessState extends EditNoteState {}

class EditNoteErrorState extends EditNoteState {}

class EditNoteUpdatedState extends EditNoteState {
  final String title;
  final String description;

  EditNoteUpdatedState({required this.title, required this.description});
}
