import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/common/color_constant.dart';
import 'package:note_app/features/edit_note/presentation/screen/edit_note_screen.dart';
import 'package:note_app/features/home_screen/presentation/cubits/home_screen_state.dart';
import 'package:note_app/features/login/presentation/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../new_note/presentation/screen/new_note_screen.dart';
import '../cubits/home_screen_cubit.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/Home-Screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeScreenCubit>(context).getAllNoteApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorConstants.whiteColor),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Note App'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Are you sure you want to Logout?'),
                        actions: [
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    LoginScreen.routeName, (route) => false);
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.clear();
                              },
                              child: const Text('Yes')),
                          ElevatedButton(
                            onPressed: () async {
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
                    });
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: ColorConstants.whiteColor,
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
                child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
                    builder: (context, state) {
                      HomeScreenCubit homeScreenCubit =
                          BlocProvider.of<HomeScreenCubit>(context);
                      if (state is HomeScreenLoadingState) {
                        return Shimmer.fromColors(
                            baseColor: ColorConstants.greyColor300,
                            highlightColor: ColorConstants.greyColor100,
                            child: GridView.builder(
                                itemCount: 16,
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
                                }));
                      }
                      return GridView.builder(
                          itemCount:
                              homeScreenCubit.getAllNoteModelClass.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.5,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    EditNoteScreen.routeName,
                                    arguments: {
                                      'id': homeScreenCubit
                                          .getAllNoteModelClass
                                          .data![index]
                                          .id,
                                      'title': homeScreenCubit
                                          .getAllNoteModelClass
                                          .data![index]
                                          .title,
                                      'description': homeScreenCubit
                                          .getAllNoteModelClass
                                          .data![index]
                                          .description,
                                    });
                              },
                              borderRadius: BorderRadius.circular(15),
                              child: Card(
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            homeScreenCubit.getAllNoteModelClass
                                                    .data![index].title ??
                                                '',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                              homeScreenCubit
                                                      .getAllNoteModelClass
                                                      .data![index]
                                                      .description ??
                                                  '',
                                              style: const TextStyle(
                                                  fontSize: 15)),
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
                              ),
                            );
                          });
                    },
                    listener: (context, state) {})),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddNoteScreen.routeName);
        },
        tooltip: 'add note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
