import 'package:flutter/material.dart';

class AnimatedCards extends StatefulWidget {
  const AnimatedCards({
    super.key,
  });

  @override
  State<AnimatedCards> createState() => _AnimatedCardsState();
}

class _AnimatedCardsState extends State<AnimatedCards>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation1;
  late Animation<double> _rotationAnimation2;

  @override
  void initState() {
    super.initState();
    // Animation controller setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _rotationAnimation1 =
        Tween<double>(begin: -0.02, end: 0.08).animate(_controller);

    _rotationAnimation2 =
        Tween<double>(begin: 0.02, end: -0.08).animate(_controller2);

    _fadeAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller3);

    _controller.repeat(reverse: true);
    _controller2.repeat(reverse: true);
    _controller3.forward();
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
                    Icons.qr_code_rounded,
                    size: 150,
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
