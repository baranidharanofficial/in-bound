import 'package:inbound/services/auth_service.dart';
import 'package:inbound/services/local_storage.dart';
import 'package:inbound/widgets/animated_texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> signOut() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      localStoreSetUId("");
      await authService.signOut();
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SlideInText(
              value: "Settings",
              size: 30,
              align: TextAlign.center,
              weight: FontWeight.bold,
            ),
            TextButton(
              onPressed: signOut,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
