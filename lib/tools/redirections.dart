import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/forumModel.dart';
import '../controllers/forumsController.dart';

versForums(BuildContext context) async {
  List<Forum> forums = await ForumApi().allForums();

  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ForumsController(
          forums: forums,
        ),
    ),
  );
}