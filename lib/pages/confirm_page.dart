import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inbound/bloc/user_bloc.dart';
import 'package:inbound/services/connect_service.dart';
import 'package:inbound/services/user_service.dart';
import 'package:inbound/widgets/animated_texts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ConfirmPage extends StatefulWidget {
  final String result;
  final String userId;
  final String recieverId;
  const ConfirmPage({
    super.key,
    required this.result,
    required this.userId,
    required this.recieverId,
  });

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final ChatService _chatService = ChatService();
  final UserService _userService = UserService();
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
    fetchSenderData();
    super.initState();
  }

  fetchSenderData() async {
    final senderBloc = BlocProvider.of<SenderBloc>(context);
    senderBloc.add(FetchSender(widget.result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      body: SizedBox(
        width: double.infinity,
        child: BlocBuilder<SenderBloc, SenderState>(builder: (context, state) {
          if (state is SenderLoading) {
            return const CircularProgressIndicator();
          } else if (state is SenderError) {
            return const SlideInText(
              value: 'Failed',
              size: 20,
              weight: FontWeight.bold,
            );
          } else if (state is SenderLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   widget.result,
                //   style: const TextStyle(
                //     color: Colors.white,
                //   ),
                // ),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
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
                                                state.sender.name,
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
                                              data: state.sender.uid,
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
                                          state.sender.role,
                                          style: GoogleFonts.gantari(
                                            fontSize: 50.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "at ${state.sender.company}",
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
                                          state.sender.email,
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
                                          state.sender.phone,
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
                const SizedBox(
                  height: 20,
                ),
                FilledButton(
                  onPressed: () async {
                    print("${widget.recieverId}RECIEVER");
                    print("${state.sender.id}SENDER");
                    await _userService.addConnect(
                        widget.recieverId, state.sender.id);
                    await _chatService.deleteRequestsCollection(widget.userId);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFFFEEBA),
                  ),
                  child: Text(
                    'Confirm',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        }),
      ),
    );
  }
}
