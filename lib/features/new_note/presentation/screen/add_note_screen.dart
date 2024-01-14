import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/common/color_constant.dart';
import 'package:note_app/features/new_note/presentation/cubits/add_note_cubit.dart';
import 'package:note_app/features/new_note/presentation/cubits/add_note_state.dart';
import 'package:shimmer/shimmer.dart';

class AddNoteScreen extends StatefulWidget {
  static const String routeName = '/Add-Note-Screen';
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Function? onAddNoteSuccess;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    onAddNoteSuccess = args['onAddNoteSuccess'];
      return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: ColorConstants.whiteColor),
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: const Text('New Note')),
        body: BlocConsumer<AddNoteCubit, AddNoteState>(
          builder: (context, state) {
            if (state is AddNoteLoadingState) {
              return Shimmer.fromColors(
                  baseColor: ColorConstants.greyColor300,
                  highlightColor: ColorConstants.greyColor100,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Title:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Card(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Enter here...',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Description:',
                            style: TextStyle(
                                fontSize: 20, color: ColorConstants.greyColor),
                          ),
                          Card(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 1.7,
                              child: const TextField(
                                maxLines: null,
                                decoration: InputDecoration(
                                    hintText: 'Enter here...',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
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
                                      onPressed: () {},
                                      child: const Text('cancel'))),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstants.primaryColor),
                                      onPressed: () {},
                                      child: const Text(
                                        'Save',
                                        style: TextStyle(
                                            color: ColorConstants.whiteColor,
                                            fontWeight: FontWeight.bold),
                                      )))
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Title:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Card(
                        child: TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                              hintText: 'Enter here...',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Title is required.";
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Description:',
                        style: TextStyle(
                            fontSize: 20, color: ColorConstants.greyColor),
                      ),
                      Card(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.7,
                          child: TextFormField(
                            controller: descriptionController,
                            maxLines: null,
                            decoration: const InputDecoration(
                                hintText: 'Enter here...',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Description is required.";
                              }
                            },
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
                                      backgroundColor:
                                          ColorConstants.primaryColor),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      await context
                                          .read<AddNoteCubit>()
                                          .addNoteApi(titleController.text,
                                              descriptionController.text);
                                    }
                                  },
                                  child: const Text(
                                    'Save',
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
            );
          },
          listener: (context, state) {
            if (state is AddNoteTitleDescriptionEmptyState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please enter the title and description.')));
            }
            if (state is AddNoteSuccessState) {
              onAddNoteSuccess?.call();
              Navigator.of(context).pop();
            }
          },
        ));
  }
}
