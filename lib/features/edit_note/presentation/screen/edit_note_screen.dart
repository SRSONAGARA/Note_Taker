import 'package:flutter/material.dart';

import '../../../../common/color_constant.dart';

class EditNoteScreen extends StatefulWidget {
  static const String routeName = '/Edit-Note-Screen';
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    titleController.text = args['title'] ?? '';
    descriptionController.text = args['description'] ?? '';
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: ColorConstants.whiteColor),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Edit Note')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: TextField(
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
                  child: TextField(
                    controller: descriptionController,
                    maxLines: null,
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
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
  }
}
