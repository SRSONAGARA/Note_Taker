import 'package:flutter/material.dart';

import '../../../../common/color_constant.dart';

class EditNoteScreen extends StatefulWidget {
  static const String routeName = '/Edit-Note-Screen';
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              const Card(
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
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
                  child: const TextField(
                    maxLines: null,
                    decoration: InputDecoration(
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
        ),
      ),
    );
  }
}
