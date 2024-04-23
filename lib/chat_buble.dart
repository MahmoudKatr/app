import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message; // Stores the incoming message

  const ChatBubble({
    super.key,
    required this.message, // Make 'message' a required parameter
  });
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16.0), // Consistent padding
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(32.0),
            bottomRight: Radius.circular(32.0),
          ),
          color: kPrimaryColor, // Use your defined primary color
        ),
        child: Text(
          message, // Display the passed 'message'
          style: const TextStyle(color: Colors.white), // Consistent style
        ),
      ),
    );
  }
}

class chat_bot extends StatelessWidget {
    final String message; // Stores the incoming message
  const chat_bot({
    super.key,
    required this.message, // Make 'message' a required parameter
  });
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0xff006D84),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
