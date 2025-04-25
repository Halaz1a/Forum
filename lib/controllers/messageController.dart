import 'package:flutter/material.dart';
import '../models/messageModel.dart';
import '../views/messageView.dart';

class MessageController extends StatefulWidget {
  final List<Message> messages;

  const MessageController({super.key, required this.messages});

  @override
  MessageControllerState createState() => MessageControllerState();
}

class MessageControllerState extends State<MessageController> {
  String? error;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MessageView(
      messages: widget.messages,
      error: error,
    );
  }

  
}