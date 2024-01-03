import 'package:flutter_animate/flutter_animate.dart';
import 'package:inbound/pages/on-boarding/user_info.dart';
import 'package:inbound/widgets/animated_texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectColorPage extends StatefulWidget {
  const SelectColorPage({super.key});

  @override
  State<SelectColorPage> createState() => _SelectColorPageState();
}

class _SelectColorPageState extends State<SelectColorPage> {
  int _currentColor = 0;

  List<LinearGradient> gradients = [
    const LinearGradient(
      colors: [
        Color.fromRGBO(255, 238, 178, 1),
        Color.fromRGBO(255, 196, 219, 1)
      ],
      stops: [0.1, 0.9],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color.fromRGBO(177, 255, 167, 1),
        Color.fromRGBO(151, 196, 255, 1)
      ],
      stops: [0.1, 0.9],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color.fromRGBO(236, 167, 255, 1),
        Color.fromRGBO(255, 183, 146, 1)
      ],
      stops: [0.1, 0.9],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color.fromRGBO(236, 167, 255, 1),
        Color.fromRGBO(255, 183, 146, 1)
      ],
      stops: [0.1, 0.9],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color.fromRGBO(255, 232, 139, 1),
        Color.fromRGBO(183, 135, 255, 1)
      ],
      stops: [0.1, 0.9],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color.fromRGBO(180, 250, 255, 1),
        Color.fromRGBO(247, 255, 178, 1)
      ],
      stops: [0.1, 0.9],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 12, bottom: 16),
              child: SlideInText(
                value: "Choose color",
                size: 40,
                weight: FontWeight.bold,
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 280,
                        width: MediaQuery.of(context).size.width * 0.5,
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
                                        "hi.",
                                        style: GoogleFonts.gantari(
                                          color: Colors.grey[900],
                                          fontSize: 20,
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
                                    gradient: gradients[_currentColor],
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                          .animate()
                          .rotate(
                            duration: const Duration(milliseconds: 1500),
                            begin: -0.05,
                            end: 0,
                          )
                          .shimmer(
                            duration: const Duration(seconds: 3),
                          ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: gradients.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 80 / 40,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _currentColor = index;
                            setState(() {});
                          },
                          child: Container(
                            padding: _currentColor == index
                                ? const EdgeInsets.all(4)
                                : EdgeInsets.zero,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: _currentColor == index
                                  ? Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    )
                                  : Border.all(
                                      width: 0,
                                      color: Colors.transparent,
                                    ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: gradients[index],
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ).animate().shimmer(
                                duration: const Duration(seconds: 3),
                              ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ), //   Column(
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserInfoPage(color: _currentColor),
                    ),
                  );
                },
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'continue',
                      style: GoogleFonts.gantari(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
