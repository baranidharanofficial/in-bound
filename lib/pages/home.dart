import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inbound/bloc/user_bloc.dart';
import 'package:inbound/pages/card_page.dart';
import 'package:inbound/pages/confirm_page.dart';
import 'package:inbound/pages/connections.dart';
import 'package:inbound/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:inbound/services/connect_service.dart';
import 'package:inbound/widgets/animated_texts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> screens = [
    const CardPage(),
    const ConnectionsPage(),
    const SettingsPage(),
  ];

  fetchConnects(String userId) async {
    final connectsBloc = BlocProvider.of<ConnectsBloc>(context);
    connectsBloc.add(FetchConnects(userId));
  }

  int _currentindex = 0;
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoading) {
        return const CircularProgressIndicator(
          color: Colors.deepPurple,
        );
      } else if (state is UserLoaded) {
        return StreamBuilder(
            stream: _chatService.getConnectionRequest(state.user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("");
                return const Text('Error');
              }

              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                return ConfirmPage(
                  recieverId: state.user.id ?? "",
                  userId: state.user.uid,
                  result: snapshot.data!.docs.isNotEmpty
                      ? snapshot.data!.docs[0].get('id')
                      : 'Empty',
                );
              }

              if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return Scaffold(
                  backgroundColor: const Color(0xFF191919),
                  body: SafeArea(
                    child: Stack(
                      children: [
                        screens[_currentindex],
                        Positioned(
                          bottom: 20,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _currentindex = 0;
                                          setState(() {});
                                        },
                                        icon: _currentindex == 0
                                            ? const SelectedIcon(
                                                icon: Icons.home,
                                                value: "Home",
                                              )
                                            : const Icon(
                                                Icons.home_outlined,
                                                size: 32,
                                                color: Colors.white,
                                              ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.event_rounded,
                                          size: 28,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          fetchConnects(state.user.id!);
                                          _currentindex = 1;
                                          setState(() {});
                                        },
                                        icon: _currentindex == 1
                                            ? const SelectedIcon(
                                                icon: Icons.group,
                                                value: "Connects",
                                              )
                                            : const Icon(
                                                Icons.group_outlined,
                                                size: 32,
                                                color: Colors.white,
                                              ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _currentindex = 2;
                                          setState(() {});
                                        },
                                        icon: _currentindex == 2
                                            ? const SelectedIcon(
                                                value: "Settings",
                                                icon: Icons.settings,
                                              )
                                            : const Icon(
                                                Icons.settings_outlined,
                                                size: 32,
                                                color: Colors.white,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));
            });
      } else if (state is UserError) {
        return const SlideInText(
          value: 'Failed',
          size: 20,
          weight: FontWeight.bold,
        );
      }
      return const Text('None');
    });
  }
}

class SelectedIcon extends StatelessWidget {
  final IconData icon;
  final String value;
  const SelectedIcon({
    required this.icon,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 238, 186),
                Color.fromARGB(255, 255, 197, 193),
              ],
              stops: [0.1, 0.9],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Icon(
            icon,
            size: 32,
            color: Colors.white,
          ),
        )
            .animate()
            .fadeIn(
              duration: const Duration(
                milliseconds: 300,
              ),
            )
            .slideY(
              duration: const Duration(
                milliseconds: 300,
              ),
              begin: -0.15,
            ),
        const SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
            .animate()
            .fadeIn(
              duration: const Duration(
                milliseconds: 300,
              ),
            )
            .slideY(
              duration: const Duration(
                milliseconds: 300,
              ),
              begin: 0.15,
            ),
      ],
    );
  }
}
