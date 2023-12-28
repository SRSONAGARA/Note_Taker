import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  static const String routeName = '/Add-Note-Screen';
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('New Note')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Card(
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Enter here...',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Description:',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              Card(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: const TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'Enter here...',
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
                    width: 20,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFE6902)),
                          onPressed: () {},
                          child: const Text(
                            'Done',
                            style: TextStyle(
                                color: Colors.white,
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
