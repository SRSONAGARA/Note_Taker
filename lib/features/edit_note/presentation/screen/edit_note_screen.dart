import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/edit_note/presentation/cubits/edit_note_cubit.dart';
import 'package:note_app/features/home_screen/presentation/cubits/home_screen_cubit.dart';

import '../../../../common/color_constant.dart';

class EditNoteScreen extends StatefulWidget {
  static const String routeName = '/Edit-Note-Screen';
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      if (titleController.text.isEmpty) {
        titleController.text = args['title'] ?? '';
      }
      if (descriptionController.text.isEmpty) {
        descriptionController.text = args['description'] ?? '';
      }
    }
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: ColorConstants.whiteColor),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Edit Note')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: TextFormField(
                    controller: titleController,
                    maxLines: null,
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: null,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('cancel'))),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.primaryColor),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                if (args != null) {
                                  final id = args['id'];
                                  final title = titleController.text;
                                  final description =
                                      descriptionController.text;

                                  context
                                      .read<EditNoteCubit>()
                                      .editNoteApi(id, title, description);
                                  context
                                      .read<HomeScreenCubit>()
                                      .getAllNoteApi();

                                  Navigator.of(context).pop();
                                }
                              }
                            },
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                  color: ColorConstants.whiteColor,
                                  fontWeight: FontWeight.bold),
                            )))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
