import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbound/bloc/user_bloc.dart';
import 'package:inbound/models/user.dart';
import 'package:inbound/pages/home.dart';
import 'package:inbound/pages/on-boarding/user_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PreviewPage extends StatefulWidget {
  final User user;
  const PreviewPage({super.key, required this.user});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  bool isBack = true;
  double angle = 0;

  void _flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
      print(angle);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  addUser(User user) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(AddUser(user));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: angle),
                duration: const Duration(milliseconds: 800),
                builder: (BuildContext context, double val, __) {
                  //here we will change the isBack val so we can change the content of the card
                  if (val >= (pi / 2)) {
                    isBack = false;
                  } else {
                    isBack = true;
                  }
                  return (Transform(
                    //let's make the card flip by it's center
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(val),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: isBack
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                          right: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.user.name,
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.gantari(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: _flip,
                                              icon: Icon(
                                                Icons.rotate_left,
                                                size: 30,
                                                color: Colors.grey[850],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(
                                                  255, 255, 238, 186),
                                              Color.fromARGB(
                                                  255, 255, 197, 193),
                                            ],
                                            stops: [0.1, 0.9],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: Center(
                                          child: QrImageView(
                                            data: widget.user.uid,
                                            version: QrVersions.auto,
                                            gapless: false,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ) //if it's back we will display here
                            : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..rotateY(
                                      pi), // it will flip horizontally the container
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "I'm a",
                                              style: GoogleFonts.gantari(
                                                fontSize: 28.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: _flip,
                                              icon: Icon(
                                                Icons.rotate_right,
                                                size: 30,
                                                color: Colors.grey[850],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                        widget.user.role,
                                        style: GoogleFonts.gantari(
                                          fontSize: 50.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "at ${widget.user.company}",
                                        style: GoogleFonts.gantari(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Reach me out :",
                                        style: GoogleFonts.gantari(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(
                                              "assets/linkedin.png",
                                              height: 30,
                                              width: 30,
                                            ),
                                            Image.asset(
                                              "assets/instagram.png",
                                              height: 30,
                                              width: 30,
                                            ),
                                            Image.asset(
                                              "assets/twitter.png",
                                              height: 30,
                                              width: 30,
                                            ),
                                            Image.asset(
                                              "assets/facebook.png",
                                              height: 30,
                                              width: 30,
                                            ),
                                            const Icon(
                                              Icons.person,
                                              size: 30,
                                              color: Colors.deepPurple,
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Colors.grey[300],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        widget.user.email,
                                        style: GoogleFonts.gantari(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        widget.user.phone,
                                        style: GoogleFonts.gantari(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ) //else we will display it here,
                        ),
                  ));
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  addUser(widget.user);
                },
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'create card',
                      style: GoogleFonts.gantari(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserInfoPage(
                        color: 0,
                      ),
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
                      'edit details',
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
        ),
      ),
    );
  }
}
