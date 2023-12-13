import 'package:inbound/pages/card_page.dart';
import 'package:inbound/pages/connections.dart';
import 'package:inbound/pages/settings.dart';
import 'package:flutter/material.dart';

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
                            icon: _currentindex == 0
                                ? const SelectedIcon(
                                    icon: Icons.home,
                                  )
                                : const Icon(
                                    Icons.home_outlined,
                                    size: 32,
                                    color: Colors.white,
                                  ),
                          ),
                          IconButton(
                            onPressed: () {
                              _currentindex = 1;
                              setState(() {});
                            },
                            icon: _currentindex == 1
                                ? const SelectedIcon(
                                    icon: Icons.group,
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
}

class SelectedIcon extends StatelessWidget {
  final IconData icon;
  const SelectedIcon({
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
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
    );
  }
}
