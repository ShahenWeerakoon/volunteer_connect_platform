import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class OrganizerHome extends StatelessWidget {
  OrganizerHome({super.key});

  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organizer Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async => await auth.logout(),
          )
        ],
      ),
      body: const Center(
        child: Text("Welcome Organizer 👋"),
      ),
    );
  }
}
