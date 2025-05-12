import 'package:flutter/material.dart';
import '../main.dart';
import '../models/forumModel.dart';
import '../models/messageModel.dart';
import '../views/forumView.dart';

class ForumController extends StatefulWidget {
  final List<Message> messages;
  final int forumId;

  const ForumController({super.key, required this.messages, required this.forumId});

  @override
  ForumControllerState createState() => ForumControllerState();
}

class ForumControllerState extends State<ForumController> {
  String? error;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ForumView(
      messages: widget.messages,
      forumId: widget.forumId,
      error: error,
    );
  }

  
}