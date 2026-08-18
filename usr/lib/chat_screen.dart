import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: const Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              'User ${index + 1}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Tap to chat...',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
            onTap: () {
              // Open chat detail
            },
          );
        },
      ),
    );
  }
}
