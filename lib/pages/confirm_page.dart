import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbound/bloc/user_bloc.dart';
import 'package:inbound/bloc/user_event.dart';
import 'package:inbound/services/connect_service.dart';
import 'package:inbound/services/user_service.dart';
import 'package:inbound/widgets/animated_texts.dart';

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
      body: BlocBuilder<SenderBloc, SenderState>(builder: (context, state) {
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
              Text(
                widget.result,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () async {
                  print("${widget.recieverId}RECIEVER");
                  print("${state.sender.id}SENDER");
                  await _userService.addConnect(
                      widget.recieverId, state.sender.id);
                  await _chatService.deleteRequestsCollection(widget.userId);
                },
                child: const Text('Confirm'),
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
    );
  }
}
