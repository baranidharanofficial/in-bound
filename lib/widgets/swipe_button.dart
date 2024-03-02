import 'package:flutter_animate/flutter_animate.dart';
import 'package:inbound/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideToUnlock extends StatefulWidget {
  const SlideToUnlock({super.key});

  @override
  State<SlideToUnlock> createState() => _SlideToUnlockState();
}

class _SlideToUnlockState extends State<SlideToUnlock> {
  double currentPosition = 0;
  double unlockPosition = 250;

  @override
  void initState() {
    super.initState();
  }

  void onSlideUpdate(double delta, double width) {
    setState(() {
      currentPosition += delta;
      if (currentPosition > (width - 80)) {
        // print('Locked!------$width');
        // print('Unlocked!------$currentPosition');
        currentPosition = width - 80;
      }
      if (currentPosition < 0) {
        currentPosition = 0;
      }
    });

    if (currentPosition >= unlockPosition) {
      currentPosition = width - 80;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
      // print('Unlocked!------$currentPosition');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        onSlideUpdate(
            details.delta.dx, MediaQuery.of(context).size.width * 0.95);
      },
      onHorizontalDragEnd: (details) {
        // print(currentPosition > MediaQuery.of(context).size.width * 0.95);
        if (currentPosition < unlockPosition) {
          setState(() {
            currentPosition = 0;
          });
        }
      },
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'swipe to create account',
                  style: GoogleFonts.gantari(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: false),
                )
                .shimmer(
                  color: const Color(0x7C616161),
                  duration: const Duration(milliseconds: 800),
                ),
          ),
          Positioned(
            left: currentPosition,
            child: Container(
              height: 70,
              width: 70,
              margin: const EdgeInsets.only(left: 5, top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Center(
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
