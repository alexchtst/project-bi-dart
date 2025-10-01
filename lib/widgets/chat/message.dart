import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.role, required this.content});

  final String role; // "user" atau "bot"
  final String content;

  @override
  Widget build(BuildContext context) {
    bool isUser = role == "user"; // cek role

    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.35,
          ),
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.01,
            horizontal: MediaQuery.of(context).size.width * 0.01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width * 0.02,
            ),
            color: isUser ? Colors.blueAccent : Colors.grey.shade700,
          ),
          child: Text(
            content,
            style: TextStyle(
              fontFamily: 'Baloo',
              fontSize: MediaQuery.of(context).size.width * 0.02,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
