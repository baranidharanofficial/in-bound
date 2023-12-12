import 'package:flutter/material.dart';

class AnimatedCards extends StatefulWidget {
  const AnimatedCards({
    super.key,
  });

  @override
  State<AnimatedCards> createState() => _AnimatedCardsState();
}

class _AnimatedCardsState extends State<AnimatedCards>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation1;
  late Animation<double> _rotationAnimation2;

  @override
  void initState() {
    super.initState();
    // Animation controller setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _rotationAnimation1 =
        Tween<double>(begin: 0, end: 0.08).animate(_controller);

    _rotationAnimation2 =
        Tween<double>(begin: 0, end: -0.08).animate(_controller);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: RotationTransition(
            turns: _rotationAnimation2,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: const Color(0xFF272727),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: _fadeAnimation,
          child: RotationTransition(
            turns: _rotationAnimation1,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Colors.deepPurpleAccent, Colors.cyanAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: const Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
