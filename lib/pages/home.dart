import 'package:inbound/pages/card_page.dart';
import 'package:inbound/pages/connections.dart';
import 'package:inbound/pages/settings.dart';
import 'package:inbound/pages/user_info.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> screens = [
    const CardPage(),
    const UserInfoPage(),
    const ConnectionsPage(),
    const SettingsPage(),
  ];

  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
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
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              _currentindex = 0;
                              setState(() {});
                            },
                            icon: ShaderMask(
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
                              child: const Icon(
                                Icons.home,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _currentindex = 1;
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.edit_note_outlined,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _currentindex = 2;
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.group_outlined,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _currentindex = 3;
                              setState(() {});
                            },
                            icon: const Icon(
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
}
