import 'package:flutter/material.dart';
import 'package:inbound/services/connect_service.dart';

class ConfirmPage extends StatefulWidget {
  final String result;
  const ConfirmPage({super.key, required this.result});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final ChatService _chatService = ChatService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      body: Center(
        child: Text(
          widget.result,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
