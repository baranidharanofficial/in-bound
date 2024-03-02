import 'package:inbound/widgets/animated_cards.dart';
import 'package:inbound/widgets/animated_texts.dart';
import 'package:inbound/widgets/onboard_button.dart';
import 'package:flutter/material.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SlideInText(
                        value: "Here we",
                        size: 72,
                        weight: FontWeight.bold,
                      ),
                      SlideInText(
                        value: "create",
                        size: 72,
                        weight: FontWeight.bold,
                      ),
                      SlideInText(
                        value: "networks",
                        size: 72,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 220,
                        child: SlideInText(
                          value:
                              "wherever you go create meaningful connections and manage them in one place.",
                          size: 16,
                          align: TextAlign.center,
                          weight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      CustomButton(),
                    ],
                  ),
                ),
              ),
              const AnimatedCards(),
            ],
          ),
        ),
      ),
    );
  }
}
