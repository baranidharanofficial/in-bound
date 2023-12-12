import 'package:inbound/services/connect_service.dart';
import 'package:inbound/widgets/animated_texts.dart';
import 'package:flutter/material.dart';

class ConnectionsPage extends StatefulWidget {
  const ConnectionsPage({super.key});

  @override
  State<ConnectionsPage> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {
  final ChatService _chatService = ChatService();

  Widget _buildRequestsList() {
    return StreamBuilder(
      stream: _chatService.getConnectionRequest('81lz2GPiXwMSFdaCNU5pne7RJF13'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        debugPrint("${snapshot.data!.docs.length}---------");

        return SlideInText(
          value: 'Requests: ${snapshot.data!.docs.length}',
          size: 30,
          align: TextAlign.center,
          weight: FontWeight.bold,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SlideInText(
            value: "Your Connections",
            size: 30,
            align: TextAlign.center,
            weight: FontWeight.bold,
          ),
          _buildRequestsList(),
        ],
      ),
    );
  }
}
