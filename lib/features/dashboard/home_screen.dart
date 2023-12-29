import 'package:flutter/material.dart';
import 'package:note_app/features/new_note/new_note_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/Home-Screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showShimmer = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          setState(() {
            showShimmer = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Note App'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'Search here...',
                  suffixIcon: const Icon(Icons.search),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 13),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: showShimmer
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: GridView.builder(
                          itemCount: 20,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.5,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4),
                          itemBuilder: (context, index) {
                            return const Card(
                              child: Stack(
                                children: [],
                              ),
                            );
                          }))
                  : GridView.builder(
                      itemCount: 20,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4),
                      itemBuilder: (context, index) {
                        return Card(
                          child: Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Title',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('Description'),
                                  ],
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        size: 20,
                                      ))),
                            ],
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddNoteScreen.routeName);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
