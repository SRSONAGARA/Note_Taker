import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/edit_note/presentation/cubits/edit_note_cubit.dart';
import 'package:note_app/features/edit_note/presentation/cubits/edit_note_state.dart';
import 'package:shimmer/shimmer.dart';
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
  String? id;
  Function? onEditSuccess;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
      id = args['id'];
      onEditSuccess = args['onEditSuccess'];
    }
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: ColorConstants.whiteColor),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Edit Note'),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Are you sure you want to delete?'),
                        actions: [
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await BlocProvider.of<EditNoteCubit>(context)
                                    .deleteNoteApi(id!);
                              },
                              child: const Text('Yes')),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.primaryColor),
                            child: const Text(
                              'No',
                              style:
                                  TextStyle(color: ColorConstants.whiteColor),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: BlocConsumer<EditNoteCubit, EditNoteState>(
            builder: (context, state) {
          if (state is EditNoteLoadingState) {
            return Shimmer.fromColors(
              baseColor: ColorConstants.greyColor300,
              highlightColor: ColorConstants.greyColor100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: TextFormField(
                      maxLines: null,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: TextFormField(
                        maxLines: null,
                        decoration: const InputDecoration(
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
                              onPressed: () {}, child: const Text('cancel'))),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.primaryColor),
                              onPressed: () {},
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
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: SizedBox(
                        child: TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                              hintText: 'Title',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                          validator: (value){
                            if(value!.isEmpty){
                              return "Title is required.";
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: TextFormField(
                          controller: descriptionController,
                          maxLines: null,
                          decoration: const InputDecoration(
                              hintText: 'Description',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                          validator: (value){
                            if(value!.isEmpty){
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
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    if (args != null) {
                                      final id = args['id'];
                                      final title = titleController.text;
                                      final description =
                                          descriptionController.text;

                                      await context
                                          .read<EditNoteCubit>()
                                          .editNoteApi(id, title, description);
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
          );
        }, listener: (context, state) {
          if (state is EditNoteTitleDescriptionEmptyState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter the title and description.')));
          }
          if (state is EditNoteSuccessState) {
            onEditSuccess?.call();
            Navigator.of(context).pop();
          }
        }));
  }
}
