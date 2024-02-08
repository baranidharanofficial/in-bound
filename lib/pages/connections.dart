import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbound/bloc/user_bloc.dart';
import 'package:inbound/bloc/user_event.dart';
// import 'package:inbound/services/connect_service.dart';
import 'package:inbound/widgets/animated_texts.dart';
import 'package:flutter/material.dart';

class ConnectionsPage extends StatefulWidget {
  const ConnectionsPage({
    super.key,
  });

  @override
  State<ConnectionsPage> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {
  // final ChatService _chatService = ChatService();

  // Widget _buildRequestsList(String uid) {
  //   return StreamBuilder(
  //     stream: _chatService.getConnectionRequest(uid),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return const Text('Error');
  //       }

  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Text('Loading...');
  //       }

  //       return SlideInText(
  //         value:
  //             'Requests: ${snapshot.data!.docs.isNotEmpty ? snapshot.data!.docs[0].get('id') : 'Empty'}',
  //         size: 20,
  //         align: TextAlign.center,
  //         weight: FontWeight.bold,
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const CircularProgressIndicator();
              } else if (state is UserLoaded) {
                final user = state.user;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SlideInText(
                      value: "Your Connects",
                      size: 30,
                      align: TextAlign.center,
                      weight: FontWeight.bold,
                    ),
                    SlideInText(
                      value: state.user.connects.length.toString(),
                      size: 30,
                      align: TextAlign.center,
                      weight: FontWeight.bold,
                    ),

                    SlideInText(
                      value: 'Name: ${user.name}',
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    // Display other user details as needed
                  ],
                );
              } else if (state is UserError) {
                return const SlideInText(
                  value: 'Failed',
                  size: 20,
                  weight: FontWeight.bold,
                );
              }
              return const Text('None');
            },
          ),
        ],
      ),
    );
  }
}
