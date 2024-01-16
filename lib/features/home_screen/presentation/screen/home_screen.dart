import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/common/color_constant.dart';
import 'package:note_app/features/edit_note/presentation/screen/edit_note_screen.dart';
import 'package:note_app/features/home_screen/presentation/cubits/home_screen_state.dart';
import 'package:note_app/features/login/presentation/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../new_note/presentation/screen/add_note_screen.dart';
import '../cubits/home_screen_cubit.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/Home-Screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenCubit homeScreenCubit;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    homeScreenCubit = BlocProvider.of<HomeScreenCubit>(context);
    getAllNotes();
  }

  Future<void> getAllNotes() async {
    await BlocProvider.of<HomeScreenCubit>(context).getAllNoteApi();
  }

  Future<void> onEditSuccess() async {
    await getAllNotes();
    searchController.clear();
  }

  Future<void> onAddNoteSuccess() async {
    await getAllNotes();
  }

  void onSearch(String query) {
    homeScreenCubit.filterNotes(query);
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
              controller: searchController,
              onChanged: onSearch,
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
            Expanded(child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                builder: (context, state) {
                  HomeScreenCubit homeScreenCubit =
                  BlocProvider.of<HomeScreenCubit>(context);
                  if (state is HomeScreenLoadingState) {
                    return Shimmer.fromColors(
                        baseColor: ColorConstants.greyColor300,
                        highlightColor: ColorConstants.greyColor100,
                        child: GridView.builder(
                            itemCount: 10,
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
                  if (homeScreenCubit.getAllNoteModelClass.data!.isEmpty) {
                    return const Center(
                      child: Text("You haven't yet added any notes."),
                    );
                  }
                  if (homeScreenCubit.filteredNotes.isEmpty) {
                    return const Center(
                      child: Text("No search items match."),
                    );
                  }
                  return GridView.builder(
                      itemCount: homeScreenCubit.filteredNotes.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4),
                      itemBuilder: (context, index) {
                        final note = homeScreenCubit.filteredNotes[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              EditNoteScreen.routeName,
                              arguments: {
                                'id': note.id,
                                'title': note.title,
                                'description': note.description,
                                'onEditSuccess': onEditSuccess
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Card(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 10,bottom: 10, right: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          note.title ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Text(note.description ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 15)),
                                      ),
                                    ],
                                  ),
                                ),
                                const Positioned(
                                    right: 5,
                                    top: 5,
                                    child: Icon(
                                      Icons.edit,
                                      size: 15,
                                      color: ColorConstants.primaryColor,
                                    )),
                              ],
                            ),
                          ),
                        );
                      });
                })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddNoteScreen.routeName,
              arguments: {'onAddNoteSuccess': onAddNoteSuccess});
        },
        tooltip: 'add note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
