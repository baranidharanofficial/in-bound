import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inbound/bloc/user_bloc.dart';
import 'package:inbound/models/user.dart';
import 'package:inbound/widgets/animated_texts.dart';
import 'package:flutter/material.dart';

class ConnectionsPage extends StatefulWidget {
  const ConnectionsPage({
    super.key,
  });

  @override
  State<ConnectionsPage> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {
  TextEditingController categoryController = TextEditingController();

  addCategory(User user, String category) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(AddCategory(user, category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF191919),
        title: const SlideInText(
          value: "Your Connects",
          size: 24,
          align: TextAlign.center,
          weight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                      if (state is UserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserLoaded) {
                        return Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.5,
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Color(0xFF191919),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add group",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              TextField(
                                controller: categoryController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              FilledButton(
                                onPressed: () {
                                  if (categoryController.text.isNotEmpty) {
                                    addCategory(
                                      state.user,
                                      categoryController.text.trim(),
                                    );
                                    // Navigator.pop(context);
                                  }
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFEEBA),
                                ),
                                child: Text(
                                  "Add Category",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else if (state is UserError) {
                        return const SizedBox();
                      }
                      return const Center(child: CircularProgressIndicator());
                    });
                  },
                );
              },
              icon: const Icon(
                Icons.group_add,
                size: 24,
                color: Colors.orangeAccent,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ConnectsBloc, ConnectsState>(
              builder: (context, state) {
                if (state is ConnectsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ConnectsLoaded) {
                  final connects = state.connect.connects;
                  final categories = state.connect.categories;
                  return categories.length == 1
                      ? Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 20),
                            itemCount: connects.length,
                            itemBuilder: (context, index) {
                              if (index < 10) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900]!,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.grey[700],
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                connects[index].name,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                "${connects[index].role} at ${connects[index].company}",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return AddUserToCategoryBS(
                                                categories: categories,
                                                connect: connects[index],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Color(0xFFFFEEBA),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        )
                      : DefaultTabController(
                          length: categories.length,
                          child: Expanded(
                            child: Column(
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  tabAlignment: TabAlignment.start,
                                  padding: EdgeInsets.zero,
                                  labelStyle: GoogleFonts.poppins(
                                    color: Colors.black,
                                  ),
                                  unselectedLabelColor: Colors.white,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorPadding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  indicatorColor: Colors.transparent,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.orangeAccent,
                                  ),
                                  dividerColor: Colors.transparent,
                                  // isScrollable: true,
                                  tabs: categories
                                      .map(
                                        (category) => Tab(text: category),
                                      )
                                      .toList(),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: categories
                                        .map(
                                          (category) => category == "All"
                                              ? ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  itemCount: connects.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (index < 10) {
                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 16,
                                                          vertical: 12,
                                                        ),
                                                        margin: const EdgeInsets
                                                            .only(bottom: 12),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[900]!,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                  ),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .person,
                                                                      color: Colors
                                                                              .grey[
                                                                          700],
                                                                      size: 35,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 12,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      connects[
                                                                              index]
                                                                          .name,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "${connects[index].role} at ${connects[index].company}",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            IconButton(
                                                              onPressed: () {
                                                                showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AddUserToCategoryBS(
                                                                      categories:
                                                                          categories,
                                                                      connect:
                                                                          connects[
                                                                              index],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                Icons.more_vert,
                                                                color:
                                                                    Colors.grey,
                                                                size: 20,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    } else {
                                                      return const Center(
                                                        child: SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Color(
                                                                0xFFFFEEBA),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                )
                                              : ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  itemCount: connects.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    print(connects[index]
                                                        .categories
                                                        .contains(category));
                                                    if (index < 10 &&
                                                        connects[index]
                                                            .categories
                                                            .contains(
                                                                category)) {
                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 16,
                                                          vertical: 12,
                                                        ),
                                                        margin: const EdgeInsets
                                                            .only(bottom: 12),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[900]!,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                  ),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .person,
                                                                      color: Colors
                                                                              .grey[
                                                                          700],
                                                                      size: 35,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 12,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      connects[
                                                                              index]
                                                                          .name,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "${connects[index].role} at ${connects[index].company}",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            IconButton(
                                                              onPressed: () {
                                                                showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AddUserToCategoryBS(
                                                                      categories:
                                                                          categories,
                                                                      connect:
                                                                          connects[
                                                                              index],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                Icons.more_vert,
                                                                color:
                                                                    Colors.grey,
                                                                size: 20,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    } else {
                                                      return const SizedBox();
                                                    }
                                                  },
                                                ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                  // return Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SlideInText(
                  //       value: state.user.connects.length.toString(),
                  //       size: 30,
                  //       align: TextAlign.center,
                  //       weight: FontWeight.bold,
                  //     ),
                  //   ],
                  // );
                } else if (state is ConnectsError) {
                  return const SlideInText(
                    value: 'Failed',
                    size: 20,
                    weight: FontWeight.bold,
                  );
                }
                return const Center(
                  child: SlideInText(
                    value: 'No connects yet',
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddUserToCategoryBS extends StatefulWidget {
  final List<String> categories;
  final User connect;
  const AddUserToCategoryBS({
    super.key,
    required this.categories,
    required this.connect,
  });

  @override
  State<AddUserToCategoryBS> createState() => _AddUserToCategoryBSState();
}

class _AddUserToCategoryBSState extends State<AddUserToCategoryBS> {
  List<String> selectedCategories = [];

  addUserToCategory(
      User user, String connectId, List<String> categories) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(AddUserToCategory(user, connectId, categories));

    final connectsBloc = BlocProvider.of<ConnectsBloc>(context);
    connectsBloc.add(FetchConnects(user.id!));
  }

  @override
  void initState() {
    print(widget.connect.categories);
    selectedCategories = widget.connect.categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectsBloc, ConnectsState>(builder: (context, state) {
      if (state is ConnectsLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is ConnectsLoaded) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFF191919),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Add to category",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Wrap(
                spacing: 8,
                children: widget.categories
                    .map(
                      (category) => category != 'All'
                          ? GestureDetector(
                              onTap: () {
                                if (selectedCategories.contains(category)) {
                                  selectedCategories.remove(category);
                                } else {
                                  selectedCategories.add(category);
                                }
                                setState(() {});
                              },
                              child: Chip(
                                backgroundColor:
                                    selectedCategories.contains(category)
                                        ? Colors.orangeAccent
                                        : Colors.grey[900],
                                side: BorderSide.none,
                                label: Text(
                                  category,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: selectedCategories.contains(category)
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    )
                    .toList(),
              ),
              BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                if (state is UserLoaded) {
                  return FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      addUserToCategory(
                        state.user,
                        widget.connect.id!,
                        selectedCategories,
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                    ),
                    child: Text(
                      "Add to Category",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
            ],
          ),
        );
      } else if (state is ConnectsError) {
        return const SizedBox();
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
