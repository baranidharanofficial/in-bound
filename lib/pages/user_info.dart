import 'package:inbound/pages/preview_page.dart';
import 'package:inbound/widgets/animated_texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 24, top: 24),
              child: SlideInText(
                value: "Fill your details",
                size: 40,
                weight: FontWeight.bold,
              ),
            ),
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const CustomInput(
                      hint: "Full name",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CustomInput(
                      hint: "Email address",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CustomInput(
                      hint: "Phone number",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CustomInput(
                      hint: "What you're doing ?",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CustomInput(
                      hint: "Where you're working ?",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                top: 8,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[850],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12),
                                      child: Text(
                                        "Your Social Links",
                                        style: GoogleFonts.gantari(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          height: 1.1,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/linkedin.png",
                                            height: 40,
                                            width: 40,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          const Expanded(
                                            child: CustomInput2(
                                              hint: "LinkedIn profile link",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/instagram.png",
                                            height: 40,
                                            width: 40,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          const Expanded(
                                            child: CustomInput2(
                                              hint: "Insta profile link",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              "assets/twitter.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          const Expanded(
                                            child: CustomInput2(
                                              hint: "X profile link",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Done',
                                            style: GoogleFonts.gantari(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(22),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[700]!,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "+ Add Links",
                            style: GoogleFonts.gantari(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PreviewPage(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'preview card',
                      style: GoogleFonts.gantari(
                        color: Colors.black,
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

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.hint,
  });

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        cursorColor: Colors.white,
        style: GoogleFonts.gantari(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.gantari(
            color: Colors.grey[700],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CustomInput2 extends StatelessWidget {
  const CustomInput2({
    super.key,
    required this.hint,
  });

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        cursorColor: Colors.white,
        style: GoogleFonts.gantari(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.gantari(
            color: Colors.grey[700],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
