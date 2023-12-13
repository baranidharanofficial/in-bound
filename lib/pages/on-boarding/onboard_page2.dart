import 'package:inbound/widgets/animated_texts.dart';
import 'package:inbound/widgets/swipe_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardPage2 extends StatefulWidget {
  const OnBoardPage2({super.key});

  @override
  State<OnBoardPage2> createState() => _OnBoardPage2State();
}

class _OnBoardPage2State extends State<OnBoardPage2> {
  final ScrollController _controller = ScrollController();
  final ScrollController _controller2 = ScrollController();

  List<LinearGradient> gradients = [
    const LinearGradient(
      colors: [
        Color.fromRGBO(252, 238, 254, 1),
        Color.fromRGBO(207, 255, 255, 1)
      ],
      stops: [0.1, 0.9],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color.fromRGBO(218, 255, 221, 1),
        Color.fromRGBO(255, 204, 211, 1)
      ],
      stops: [0.1, 0.9],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color.fromRGBO(255, 243, 201, 1),
        Color.fromRGBO(255, 226, 212, 1)
      ],
      stops: [0.1, 0.9],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  List<String> texts = ["hello.", "hi.", "how r u?", "hey."];
  List<String> texts2 = ["hello.", "how r u?", "hey.", "hi."];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(_controller.position.minScrollExtent);

      _controller.animateTo(
        _controller.position.maxScrollExtent - 250,
        duration: const Duration(milliseconds: 3000),
        curve: Curves.easeInOut,
      );

      _controller2.jumpTo(_controller2.position.maxScrollExtent);

      _controller2.animateTo(
        _controller2.position.minScrollExtent,
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 16),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SlideInText(
                          value: "Custom Card",
                          size: 50,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SlideInText(
                          value: "just for you & your business.",
                          size: 12,
                          weight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: index == 0
                              ? MediaQuery.of(context).size.width
                              : 5,
                        ),
                        child: CustomCard(
                          color: gradients[index],
                          value: texts2[index],
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: const SlideToUnlock(),
                )
              ],
            ),
            Positioned(
              bottom: 100,
              child: SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ListView.builder(
                    controller: _controller2,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          right: index == 2
                              ? MediaQuery.of(context).size.width
                              : 8,
                        ),
                        child: CustomCard2(
                          color: gradients[index],
                          value: texts[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.color,
    required this.value,
  });

  final LinearGradient color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 260,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRect(
            child: Column(
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          value,
                          style: GoogleFonts.gantari(
                            color: Colors.grey[900],
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: color,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned.fill(
          left: 0,
          top: 0,
          child: Container(
            height: 260,
            width: 180,
            decoration: BoxDecoration(
              color: const Color(0x7D000000),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCard2 extends StatelessWidget {
  const CustomCard2({
    super.key,
    required this.color,
    required this.value,
  });

  final LinearGradient color;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRect(
        child: Column(
          children: [
            Container(
              height: 70,
              padding: const EdgeInsets.only(left: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: GoogleFonts.gantari(
                        color: Colors.grey[900],
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: color,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
